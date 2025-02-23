package forml.validation

import org.eclipse.xtext.validation.Check
import org.eclipse.xtext.resource.impl.ResourceDescriptionsProvider
import org.eclipse.emf.ecore.EObject
import forml.forml.FormlPackage
import com.google.inject.Inject
import org.eclipse.xtext.naming.QualifiedName

import forml.validation.FormlValidator
import forml.forml.PartialModel
import forml.forml.SimpleClass
import forml.forml.Enumeration
import forml.forml.Object
import forml.forml.Model

class FormlMultipleDeclarationsValidator extends AbstractFormlValidator {
	@Inject ResourceDescriptionsProvider rdp
	
	def getResourceDescription(EObject o) {
		val index = rdp.getResourceDescriptions(o.eResource)
		index.getResourceDescription(o.eResource.URI)
	}
	
	def getExportedEObjectDescriptions(EObject o) {
		o.getResourceDescription.getExportedObjects
	}
	
	def getExportedClassesEObjectDescriptions(EObject o) {
		o.getResourceDescription.
		getExportedObjectsByType(FormlPackage.eINSTANCE.simpleClass)
	}
	
	def getQualifiedName(EObject o) {
		var qName = QualifiedName.EMPTY
		var current = o
		
		while (current !== null) {
			switch current {
				Model,
				PartialModel,
				SimpleClass,
				Enumeration,
				Object:       qName = QualifiedName.create(current.name).append(qName)
			}
			current = current.eContainer
		}
		qName
	}
	
	public static val INCONSISTENT_CATEGORIES = FormlValidator.ISSUE_PREFIX + "InconsistentCategories"
	@Check
	def checkDeclarationsCategories(PartialModel item) {
 		for (description : item.getExportedEObjectDescriptions) {
			switch description.EObjectOrProxy {
				Model, SimpleClass, Enumeration, Object: {
					if (description.qualifiedName == item.getQualifiedName) error(
						"Inconsistent categories declared for " + item.getQualifiedName, 
						FormlPackage.eINSTANCE.name_Name,
						INCONSISTENT_CATEGORIES,
						item.name)
				} 
			}
		}
	}
	
	@Check
	def checkDeclarationsCategories(SimpleClass item) {
 		for (description : item.getExportedEObjectDescriptions) {
			switch description.EObjectOrProxy {
				Model, PartialModel, Enumeration, Object: {
					if (description.qualifiedName == item.getQualifiedName) error(
						"Inconsistent categories declared for " + item.getQualifiedName, 
						FormlPackage.eINSTANCE.name_Name,
						INCONSISTENT_CATEGORIES,
						item.name)
				}
			}
		}
	}
	
	@Check
	def checkDeclarationsCategories(Enumeration item) {
 		for (description : item.getExportedEObjectDescriptions) {
			switch description.EObjectOrProxy {
				Model, PartialModel, SimpleClass, Object: {
					if (description.qualifiedName == item.getQualifiedName) error(
						"Inconsistent categories declared for " + item.getQualifiedName, 
						FormlPackage.eINSTANCE.name_Name,
						INCONSISTENT_CATEGORIES,
						item.name)
				}
			}
		}
	}
	
	@Check
	def checkDeclarationsCategories(Object item) {
 		for (description : item.getExportedEObjectDescriptions) {
			switch description.EObjectOrProxy {
				Model, PartialModel, SimpleClass, Enumeration: {
					if (description.qualifiedName == item.getQualifiedName) error(
						"Inconsistent categories declared for " + item.getQualifiedName, 
						FormlPackage.eINSTANCE.name_Name,
						INCONSISTENT_CATEGORIES,
						item.name)
				}
			}
		}
	}
}	
