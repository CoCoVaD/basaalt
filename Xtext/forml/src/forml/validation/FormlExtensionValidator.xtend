package forml.validation

import java.util.HashSet
import org.eclipse.xtext.validation.Check

import forml.forml.FormlPackage
import forml.forml.Model
import forml.forml.SimpleClass
import forml.forml.Enumeration
import forml.forml.ClassReference

class FormlExtensionValidator extends AbstractFormlValidator {
/*
 * Checks that an item (model or class) does not extend itself
 */

	def void collectExtendedModels(HashSet<Model> collectedModels, HashSet<Model> visitedModels, Model m) {
		if (!visitedModels.contains(m)) {
			visitedModels.add(m)
			if (!collectedModels.contains(m)) collectedModels.add(m)
			if (m.extendedModels !== null)
				for (extendedModel : m.extendedModels) 
					collectExtendedModels(collectedModels, visitedModels, extendedModel.model)
		}		
	}
 
	public static val CYCLE_WITH_EXTENDED_MODELS = FormlValidator.ISSUE_PREFIX + "CycleWithExtendedModels"
	@Check
	def checkModelIsNotInExtensionClosure(Model m) {
		if (m.extendedModels === null)
			return // nothing to check
			
		val HashSet<Model> collectedModels = newHashSet
		val HashSet<Model> visitedModels = newHashSet
		for (extendedModel : m.extendedModels) 
			collectExtendedModels(collectedModels, visitedModels, extendedModel.model)
		
		if (collectedModels.contains(m)) 
			error(
				"Cycle in hierarchy extension of model " + m.name,
				FormlPackage.eINSTANCE.model_ExtendedModels,
				CYCLE_WITH_EXTENDED_MODELS)
	}
	
	def void collectExtendedClasses(HashSet<ClassReference> collectedClasses, 
									HashSet<ClassReference> visitedClasses, 
									ClassReference c) {
		if (!visitedClasses.contains(c)) {
			visitedClasses.add(c)
			if (!collectedClasses.contains(c)) collectedClasses.add(c)
			val x = c.definedClass
			if (x !== null) switch x {
				SimpleClass: 
					for (extendedClass : x.extendedClasses) 
						if (extendedClass.definedClass !== null)
							collectExtendedClasses(collectedClasses, visitedClasses, extendedClass)
				Enumeration: 
					for (extendedClass : x.extendedClasses) 
						if (extendedClass.definedClass !== null)
							collectExtendedClasses(collectedClasses, visitedClasses, extendedClass)
			}
		}		
	}
 
	public static val CYCLE_WITH_EXTENDED_CLASSES = FormlValidator.ISSUE_PREFIX + "CycleWithExtendedClasses"
	@Check
	def checkClassIsNotInExtensionClosure(SimpleClass simpleClass) {
		if (simpleClass.extendedClasses === null)
			return // nothing to check
			
		val HashSet<ClassReference> collectedClasses = newHashSet
		val HashSet<ClassReference> visitedClasses = newHashSet
		for (extendedClass : simpleClass.extendedClasses) 
				collectExtendedClasses(collectedClasses, visitedClasses, extendedClass)
		
		for (reference : collectedClasses) {
			var x = reference.definedClass
			if (x !== null) {
				var name = switch x {
					SimpleClass: x.name 
					Enumeration: x.name
				}
				if (name == simpleClass.name)
					error(
						"Cycle in hierarchy extension of class " + simpleClass.name,
						FormlPackage.eINSTANCE.extendedClasses_ExtendedClasses,
						CYCLE_WITH_EXTENDED_CLASSES)
			}
		} 
	}
	
	@Check
	def checkEnumerationIsNotInExtensionClosure(Enumeration enumeration) {
		if (enumeration.extendedClasses === null)
			return // nothing to check
			
		val HashSet<ClassReference> collectedClasses = newHashSet
		val HashSet<ClassReference> visitedClasses = newHashSet
		for (extendedClass : enumeration.extendedClasses) 
				collectExtendedClasses(collectedClasses, visitedClasses, extendedClass)
		
		for (reference : collectedClasses) {
			var x = reference.definedClass
			if (x !== null) {
				var name = switch x {
					SimpleClass: x.name 
					Enumeration: x.name
				}
				if (name == enumeration.name)
					error(
						"Cycle in hierarchy extension of enumeration " + enumeration.name,
						FormlPackage.eINSTANCE.extendedClasses_ExtendedClasses,
						CYCLE_WITH_EXTENDED_CLASSES)
			}
		} 
	}
}