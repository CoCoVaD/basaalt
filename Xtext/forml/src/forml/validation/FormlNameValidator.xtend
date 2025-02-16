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
	def checkModelNameIsNotDegree (Model model) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (model.name.charAt(0) == degree && model.name.length == 1)
			warning(
				"Models should not be named °", 
				FormlPackage.eINSTANCE.model_Name,
				INCORRECT_MODEL_NAME,
				model.name)
	}

	public static val MODEL_NAME_FIRST_CHAR_IS_DEGREE = FormlValidator.ISSUE_PREFIX + "ModelNameFirstCharIsDegree"
	@Check
	def checkModelNameFirstCharIsNotDegree (Model model) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (model.name.charAt(0) == degree && model.name.length > 1)
			warning(
				"Model names should not begin with a °", 
				FormlPackage.eINSTANCE.model_Name,
				MODEL_NAME_FIRST_CHAR_IS_DEGREE,
				model.name)
	}

	public static val UNCAPITALIZED_MODEL_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedModelName"
	@Check
	def checkModelNameDoesNotStartsWithLowerCase (Model model) {
		if (model.name.charAt(0).lowerCase)
			warning(
				"Model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.model_Name,
				UNCAPITALIZED_MODEL_NAME,
				model.name)
	}

	public static val INCORRECT_PARTIAL_MODEL_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectPartialModelName"
	@Check
	def checkPartialModelNameIsNotDegree (PartialModel partialModel) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (partialModel.name.charAt(0) == degree && partialModel.name.length == 1)
			warning(
				"Partial models should not be named °", 
				FormlPackage.eINSTANCE.partialModel_Name,
				INCORRECT_PARTIAL_MODEL_NAME,
				partialModel.name)
	}

	public static val PARTIAL_MODEL_NAME_FIRST_CHAR_IS_DEGREE = FormlValidator.ISSUE_PREFIX + "PartialModelNameFirstCharIsDegree"
	@Check
	def checkPartialModelNameDoesNotStartsWithDegree (PartialModel partialModel) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (partialModel.name.charAt(0) == degree && partialModel.name.length > 1)
			warning(
				"Partial model names should not begin with a °", 
				FormlPackage.eINSTANCE.partialModel_Name,
				PARTIAL_MODEL_NAME_FIRST_CHAR_IS_DEGREE,
				partialModel.name)
	}

	public static val UNCAPITALIZED_PARTIAL_MODEL_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedPartialModelName"
	@Check
	def checkPartialModelNameDoesNotStartWithLowerCase (PartialModel partialModel) {
		if (partialModel.name.charAt(0).lowerCase)
			warning(
				"Partial model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.partialModel_Name,
				UNCAPITALIZED_PARTIAL_MODEL_NAME,
				partialModel.name)
	}

	public static val INCORRECT_CLASS_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectClassName"
	@Check
	def checkClassNameIsNotDegree (DefinedClass definedClass) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (definedClass.name.charAt(0) == degree && definedClass.name.length == 1)
			warning(
				"Classes should not be named °", 
				FormlPackage.eINSTANCE.definedClass_Name,
				INCORRECT_CLASS_NAME,
				definedClass.name)
	}

	public static val CLASS_NAME_FIRST_CHAR_IS_DEGREE = FormlValidator.ISSUE_PREFIX + "ClassNameFirstCharIsDegree"
	@Check
	def checkClassNameDoesNotStartsWithDegree (DefinedClass dClass) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (dClass.name.charAt(0) == degree && dClass.name.length > 1)
			warning(
				"Class names should not begin with a °", 
				FormlPackage.eINSTANCE.definedClass_Name,
				CLASS_NAME_FIRST_CHAR_IS_DEGREE,
				dClass.name)
	}
	
	public static val UNCAPITALIZED_CLASS_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedClassName"
	@Check
	def checkClassNameDoesNotStartWithLowerCase (DefinedClass definedClass) {
		if (definedClass.name.charAt(0).lowerCase)
			warning(
				"Class names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.definedClass_Name,
				UNCAPITALIZED_CLASS_NAME,
				definedClass.name)
	}

	public static val CAPITALIZED_OBJECT_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectObjectName"
	@Check
	def checkObjectNameDoesNotStartsWithUpperCase (Object object) {
		if (object.name.charAt(0).upperCase)
			warning(
				"Object names should not begin with an upper case letter", 
				FormlPackage.eINSTANCE.object_Name,
				CAPITALIZED_OBJECT_NAME,
				object.name)
	}
}