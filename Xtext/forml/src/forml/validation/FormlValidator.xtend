/*
 * generated by Xtext 2.37.0
 */
package forml.validation

import org.eclipse.xtext.validation.Check
import static extension java.lang.Character.*
import java.util.HashSet
import forml.forml.FormlPackage
import forml.forml.Model
import forml.forml.PartialModel
import forml.forml.DefinedClass
import forml.forml.Object

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */


class FormlValidator extends AbstractFormlValidator {
	
	protected static val ISSUE_PREFIX = 'forml.'

/**
 * Names 
 *
 */
	public static val INCORRECT_MODEL_NAME = ISSUE_PREFIX + "IncorrectModelName"
	@Check
	def checkModelNameStartsWithUppercase (Model model) {
		if (model.name.charAt(0).lowerCase)
			warning(
				"Model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.model_Name,
				INCORRECT_MODEL_NAME,
				model.name)
	}

	public static val INCORRECT_PARTIAL_MODEL_NAME = ISSUE_PREFIX + "IncorrectPartialModelName"
	@Check
	def checkPartialModelNameStartsWithUppercase (PartialModel model) {
		if (model.name.charAt(0).lowerCase)
			warning(
				"Partial model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.partialModel_Name,
				INCORRECT_PARTIAL_MODEL_NAME,
				model.name)
	}

	public static val INCORRECT_CLASS_NAME = ISSUE_PREFIX + "IncorrectClassName"
	@Check
	def checkClassNameStartsWithUppercase (DefinedClass definedClass) {
		if (definedClass.name.charAt(0).lowerCase)
			warning(
				"Class names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.definedClass_Name,
				INCORRECT_CLASS_NAME,
				definedClass.name)
	}

	public static val INCORRECT_OBJECT_NAME = ISSUE_PREFIX + "IncorrectObjectName"
	@Check
	def checkObjectNameDoesNotStartsWithUppercase (Object object) {
		if (object.name.charAt(0).upperCase)
			warning(
				"Object names should not begin with an upper case letter", 
				FormlPackage.eINSTANCE.object_Name,
				INCORRECT_OBJECT_NAME,
				object.name)
	}

/**
 * End names 
 *
 */
	public static val NO_MODEL_END_NAME = ISSUE_PREFIX + "NoModelEndName"
	@Check
	def checkModelEndName (Model model) {
		if (model.block !== null)
			if (model.block.endName === null)
			warning(
				"Model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.model_Name,
				INCORRECT_MODEL_NAME,
				model.name)
	}


/**
 * Extension cycles 
 *
 */
	def void collectExtensions(HashSet<Model> collectedExtendedModels, HashSet<Model> visitedModels, Model m) {
		if (!visitedModels.contains(m)) {
			visitedModels.add(m)
			if (!collectedExtendedModels.contains(m)) collectedExtendedModels.add(m)
			if (m.extendedModels !== null)
				for (extendedModel : m.extendedModels) 
					collectExtensions(collectedExtendedModels, visitedModels, extendedModel.model)
		}		
	}
 
	@Check
	def checkModelNotInExtensionClosure(Model m) {
		if (m.extendedModels === null)
			return // nothing to check
			
		val HashSet<Model> collectedExtendedModels = newHashSet
		val HashSet<Model> visitedModels = newHashSet
		for (extendedModel : m.extendedModels) 
			collectExtensions(collectedExtendedModels, visitedModels, extendedModel.model)
		
		if (collectedExtendedModels.contains(m)) 
			error(
				"Cycle in hierarchy extension of Model '" + m.name + "'",
				FormlPackage.eINSTANCE.model_ExtendedModels)
	}
	
}
