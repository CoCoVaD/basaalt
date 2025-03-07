package forml.validation

import org.eclipse.xtext.validation.Check
import org.eclipse.xtext.resource.impl.ResourceDescriptionsProvider
import org.eclipse.emf.ecore.EObject
import forml.forml.FormlPackage
import com.google.inject.Inject
import org.eclipse.xtext.naming.QualifiedName

import forml.validation.FormlValidator
import forml.forml.Section
import forml.forml.SimpleClass
import forml.forml.Enumeration
import forml.forml.Object
import forml.forml.Model
import forml.forml.ClassReference
import forml.forml.States

class FormlMultipleDeclarationsValidator extends AbstractFormlValidator {
	@Inject ResourceDescriptionsProvider rdp
	
	def getResourceDescription(EObject o) {
		val index = rdp.getResourceDescriptions(o.eResource)
		index.getResourceDescription(o.eResource.URI)
	}
	
	def getExportedEObjectDescriptions(EObject o) {
		o.resourceDescription.getExportedObjects
	}
	
	def getExportedClassesEObjectDescriptions(EObject o) {
		o.resourceDescription.
		getExportedObjectsByType(FormlPackage.eINSTANCE.simpleClass)
	}
	
	def getQualifiedName(EObject o) {
		var qName = QualifiedName.EMPTY
		var current = o
		
		while (current !== null) {
			switch current {
				Model,
				Section,
				SimpleClass,
				Enumeration,
				Object:       qName = QualifiedName.create(current.name).append(qName)
			}
			current = current.eContainer
		}
		qName
	}
	
	def classReferenceQName(ClassReference ref) {
		if (ref.preDefinedClass !== null) QualifiedName.create(ref.preDefinedClass) 
		else switch ref.definedClass {
				SimpleClass, Enumeration: {
					ref.definedClass.qualifiedName
				}
			}	
	}
	
	def boolean isEqualTo(States s1, States s2) {
		if (s1 === null && s2 === null) return true
		if (s1 !== null && s2 === null) return false
		if (s1 === null && s2 !== null) return false
		if (s1.states.length != s2.states.length) return false
		if (s1.list != s2.list || s1.product != s2.product) return false
		val names1 = s1.states.map[name].sort
		val names2 = s2.states.map[name].sort
		if (!names1.equals(names2)) return false
		val states1 = s1.states.sortBy[name].map[states]
		val states2 = s2.states.sortBy[name].map[states]
		for (var i=0 ; i< states1.length ; i++) 
			if (!states1.get(i).isEqualTo(states2.get(i))) return false
 		val enum1 = s1.states.sortBy[name].map[enumeration.qualifiedName]
		val enum2 = s2.states.sortBy[name].map[enumeration.qualifiedName]
		for (var i=0 ; i< states1.length ; i++) 
			if (!enum1.get(i).equals(enum2.get(i))) return false
		true
	}
	
	public static val INCONSISTENT_CATEGORIES  = FormlValidator.ISSUE_PREFIX + "InconsistentCategories"
	public static val INCONSISTENT_MODIFIERS   = FormlValidator.ISSUE_PREFIX + "InconsistentModifiers"
	public static val INCONSISTENT_DETERMINERS = FormlValidator.ISSUE_PREFIX + "InconsistentDeterminers"
	public static val INCONSISTENT_CLASS_LIST  = FormlValidator.ISSUE_PREFIX + "InconsistentClassLIst"
	public static val INCONSISTENT_STATES      = FormlValidator.ISSUE_PREFIX + "InconsistentStates"
	@Check
	def checkDeclarationsCategories(Section item) {
 		for (description : item.exportedEObjectDescriptions) {
			switch description.EObjectOrProxy {
				Model, SimpleClass, Enumeration, Object: {
					if (description.qualifiedName == item.qualifiedName) error(
						"Inconsistent categories declared for " + item.qualifiedName, 
						FormlPackage.eINSTANCE.name_Name,
						INCONSISTENT_CATEGORIES,
						item.qualifiedName.toString)
				} 
			}
		}
	}
	
	@Check
	def checkDeclarationsCategories(SimpleClass item) {
 		for (description : item.exportedEObjectDescriptions) {
 			var other = description.EObjectOrProxy
 			if (other.eIsProxy)
 				other = item.eResource.resourceSet.getEObject(description.EObjectURI, true)
			switch other {
				SimpleClass: {
					if (description.qualifiedName == item.getQualifiedName) {
						if (item.main != other.main) error(
							"Inconsistent 'main' modifier declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.classModifier_Main,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.external != other.external) error(
							"Inconsistent 'external' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.classModifier_External,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.private != other.private) error(
							"Inconsistent 'private' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.classModifier_Private,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.abstract != other.abstract) error(
							"Inconsistent 'abstract' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.classModifier_Abstract,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.determiner  != "" && other.determiner != "" && item.determiner != other.determiner) error(
							"Inconsistent determiners declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.simpleClass_Determiner,
							INCONSISTENT_DETERMINERS,
							item.qualifiedName.toString)
 						val itemClassQNames  = item.extendedClasses.map[classReferenceQName].sort
						val otherClassQNames = other.extendedClasses.map[classReferenceQName].sort
						if (!itemClassQNames.equals(otherClassQNames)) error(
							"Inconsistent sets of extended classes declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.extendedClasses_ExtendedClasses,
							INCONSISTENT_CLASS_LIST,
							item.qualifiedName.toString)
					}
				}
				Model, Section, Enumeration, Object: {
					if (description.qualifiedName == item.qualifiedName) error(
						"Inconsistent categories declared for " + item.qualifiedName, 
						FormlPackage.eINSTANCE.name_Name,
						INCONSISTENT_CATEGORIES,
						item.qualifiedName.toString)
				}
			}
		}
	}
	
	@Check
	def checkDeclarationsCategories(Enumeration item) {
 		for (description : item.exportedEObjectDescriptions) {
 			var other = description.EObjectOrProxy
 			if (other.eIsProxy)
 				other = item.eResource.resourceSet.getEObject(description.EObjectURI, true)
			switch other {
				Enumeration: {
					if (description.qualifiedName == item.qualifiedName) {
						if (item.main != other.main) error(
							"Inconsistent 'main' modifier declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.classModifier_Main,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.external != other.external) error(
							"Inconsistent 'external' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.classModifier_External,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.private != other.private) error(
							"Inconsistent 'private' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.classModifier_Private,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.abstract != other.abstract) error(
							"Inconsistent 'abstract' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.classModifier_Abstract,
							INCONSISTENT_MODIFIERS,
							item.name)
						if (item.determiner  != "" && other.determiner != "" && item.determiner != other.determiner) error(
							"Inconsistent determiners declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.enumeration_Determiner,
							INCONSISTENT_DETERMINERS,
							item.qualifiedName.toString)
 						val itemClassQNames  = item.extendedClasses.map[classReferenceQName].sort
						val otherClassQNames = other.extendedClasses.map[classReferenceQName].sort
						if (!itemClassQNames.equals(otherClassQNames)) error(
							"Inconsistent sets of extended classes declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.extendedClasses_ExtendedClasses,
							INCONSISTENT_CLASS_LIST,
							item.qualifiedName.toString)
						if (!item.states.isEqualTo(other.states)) error(
							"Inconsistent sets of states declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.enumeration_States,
							INCONSISTENT_STATES,
							item.qualifiedName.toString)
					}
				}
				Model, Section, SimpleClass, Object: {
					if (description.qualifiedName == item.qualifiedName) error(
						"Inconsistent categories declared for " + item.qualifiedName, 
						FormlPackage.eINSTANCE.name_Name,
						INCONSISTENT_CATEGORIES,
						item.qualifiedName.toString)
				}
			}
		}
	}
	
	@Check
	def checkDeclarationsCategories(Object item) {
 		for (description : item.exportedEObjectDescriptions) {
 			var other = description.EObjectOrProxy
 			if (other.eIsProxy)
 				other = item.eResource.resourceSet.getEObject(description.EObjectURI, true)
			switch other {
				Object: {
					if (description.qualifiedName == item.qualifiedName) {
						if (item.main != other.main) error(
							"Inconsistent 'main' modifier declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.object_Main,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.external != other.external) error(
							"Inconsistent 'external' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.object_External,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.private != other.private) error(
							"Inconsistent 'private' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.object_Private,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
					if (item.constant != other.constant) error(
							"Inconsistent 'constant' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.object_Constant,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.fixed != other.fixed) error(
							"Inconsistent 'fixed' modifiers declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.object_Fixed,
							INCONSISTENT_MODIFIERS,
							item.qualifiedName.toString)
						if (item.determiner  != "" && other.determiner != "" && item.determiner != other.determiner) error(
							"Inconsistent determiners declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.object_Determiner,
							INCONSISTENT_DETERMINERS,
							item.qualifiedName.toString)
 						val itemClassQNames  = item.classes.map[classReferenceQName].sort
						val otherClassQNames = other.classes.map[classReferenceQName].sort
						if (!itemClassQNames.equals(otherClassQNames)) error(
							"Inconsistent class lists declared for " + item.qualifiedName, 
							FormlPackage.eINSTANCE.object_Determiner,
							INCONSISTENT_CLASS_LIST,
							item.qualifiedName.toString)
					}
					
				}
				Model, Section, SimpleClass, Enumeration: {
					if (description.qualifiedName == item.qualifiedName) error(
						"Inconsistent categories declared for " + item.qualifiedName, 
						FormlPackage.eINSTANCE.name_Name,
						INCONSISTENT_CATEGORIES,
						item.qualifiedName.toString)
				}
			}
		}
	}
}	
