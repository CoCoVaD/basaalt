package forml.validation

import org.eclipse.xtext.validation.Check
import static extension java.lang.Character.*

import forml.forml.FormlPackage
import forml.validation.FormlValidator
import forml.forml.Model
import forml.forml.PartialModel
import forml.forml.DefinedClass
import forml.forml.Object

class FormlNameValidator extends AbstractFormlValidator {
/*
 * Checks that model, partial model and class names start with an upper case letter
 * Checks that object names start with a lower case letter, or a ° or an _
 * 
 */
	public static val INCORRECT_MODEL_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectModelName"
	@Check
	def checkModelNameStartsWithUppercase (Model model) {
		val char degree     = '°'	// This is necessary to prevent Xtext from
		val char underscore = '_'	// converting char literals into strings
		if (model.name.charAt(0) == degree || model.name.charAt(0) == underscore)
			warning(
				"Model names should begin neither with a ° nor with an _", 
				FormlPackage.eINSTANCE.model_Name,
				INCORRECT_MODEL_NAME,
				model.name)
	}

	public static val UNCAPITALIZED_MODEL_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedModelName"
	@Check
	def checkModelNameDoesNotStartsWithLowercase (Model model) {
		if (model.name.charAt(0).lowerCase)
			warning(
				"Model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.model_Name,
				UNCAPITALIZED_MODEL_NAME,
				model.name)
	}

	public static val INCORRECT_PARTIAL_MODEL_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectPartialModelName"
	@Check
	def checkPartialModelNameStartsWithUppercase (PartialModel partialModel) {
		val char degree     = '°'	// This is necessary to prevent Xtext from
		val char underscore = '_'	// converting char literals into strings
		if (partialModel.name.charAt(0) == degree || partialModel.name.charAt(0) == underscore)
			warning(
				"Partial model names should begin neither with a ° nor with an _", 
				FormlPackage.eINSTANCE.partialModel_Name,
				INCORRECT_PARTIAL_MODEL_NAME,
				partialModel.name)
	}

	public static val UNCAPITALIZED_PARTIAL_MODEL_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedPartialModelName"
	@Check
	def checkPartialModelNameDoesNotStartWithLowercase (PartialModel partialModel) {
		if (partialModel.name.charAt(0).lowerCase)
			warning(
				"Partial model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.partialModel_Name,
				UNCAPITALIZED_PARTIAL_MODEL_NAME,
				partialModel.name)
	}

	public static val INCORRECT_CLASS_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectClassName"
	@Check
	def checkClassNameStartsWithUppercase (DefinedClass definedlass) {
		val char degree     = '°'	// This is necessary to prevent Xtext from
		val char underscore = '_'	// converting char literals into strings
		if (definedlass.name.charAt(0) == degree || definedlass.name.charAt(0) == underscore)
			warning(
				"Class names should begin neither with a ° nor with an _", 
				FormlPackage.eINSTANCE.definedClass_Name,
				INCORRECT_CLASS_NAME,
				definedlass.name)
	}
	public static val UNCAPITALIZED_CLASS_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedClassName"
	@Check
	def checkClassNameDoesNotStartWithLowercase (DefinedClass definedClass) {
		if (definedClass.name.charAt(0).lowerCase)
			warning(
				"Class names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.definedClass_Name,
				UNCAPITALIZED_CLASS_NAME,
				definedClass.name)
	}

	public static val CAPITALIZED_OBJECT_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectObjectName"
	@Check
	def checkObjectNameDoesNotStartsWithUppercase (Object object) {
		if (object.name.charAt(0).upperCase)
			warning(
				"Object names should not begin with an upper case letter", 
				FormlPackage.eINSTANCE.object_Name,
				CAPITALIZED_OBJECT_NAME,
				object.name)
	}
}