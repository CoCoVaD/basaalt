package forml.validation

import forml.forml.DefinedClass
import forml.forml.FormlPackage
import forml.forml.Model
import java.util.HashSet
import org.eclipse.xtext.validation.Check

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
	
	def void collectExtendedClasses(HashSet<DefinedClass> collectedClasses, HashSet<DefinedClass> visitedClasses, DefinedClass c) {
		if (!visitedClasses.contains(c)) {
			visitedClasses.add(c)
			if (!collectedClasses.contains(c)) collectedClasses.add(c)
			if (c.extendedClasses !== null)
				for (extendedClass : c.extendedClasses) 
					if (extendedClass.definedClass !== null)
						collectExtendedClasses(collectedClasses, visitedClasses, extendedClass.definedClass)
		}		
	}
 
	public static val CYCLE_WITH_EXTENDED_CLASSES = FormlValidator.ISSUE_PREFIX + "CycleWithExtendedClasses"
	@Check
	def checkClassIsNotInExtensionClosure(DefinedClass c) {
		if (c.extendedClasses === null)
			return // nothing to check
			
		val HashSet<DefinedClass> collectedClasses = newHashSet
		val HashSet<DefinedClass> visitedClasses = newHashSet
		for (extendedClass : c.extendedClasses) 
			collectExtendedClasses(collectedClasses, visitedClasses, extendedClass.definedClass)
		
		if (collectedClasses.contains(c)) 
			error(
				"Cycle in hierarchy extension of class " + c.name,
				FormlPackage.eINSTANCE.definedClass_ExtendedClasses,
				CYCLE_WITH_EXTENDED_CLASSES)
	}
}