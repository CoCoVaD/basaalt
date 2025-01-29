package forml.validation

// 29 January 2025

import org.eclipse.xtext.validation.Check
import static extension java.lang.Character.*

import forml.forml.FormlPackage
import forml.forml.Model
import forml.forml.PartialModel
import forml.forml.DefinedClass
import forml.forml.Object

/**
 * This class contains custom validators for names. 
 *
 * It checks that
 * 	- template names (models, partial models and classes) begin with an upper case letter
 * 	- instance names (objects) and contract names begin with a lower case letter, or with a ° or an _
 */

class FormlNameValidator extends AbstractFormlValidator {
	
	protected static val ISSUE_PREFIX = 'forml.'

	public static val INCORRECT_MODEL_NAME = ISSUE_PREFIX + "IncorrectModelName"
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

	public static val UNCAPITALIZED_MODEL_NAME = ISSUE_PREFIX + "UncapitalizedModelName"
	@Check
	def checkModelNameDoesNotStartsWithLowercase (Model model) {
		if (model.name.charAt(0).lowerCase)
			warning(
				"Model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.model_Name,
				UNCAPITALIZED_MODEL_NAME,
				model.name)
	}

	public static val INCORRECT_PARTIAL_MODEL_NAME = ISSUE_PREFIX + "IncorrectPartialModelName"
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

	public static val UNCAPITALIZED_PARTIAL_MODEL_NAME = ISSUE_PREFIX + "UncapitalizedPartialModelName"
	@Check
	def checkPartialModelNameDoesNotStartWithLowercase (PartialModel partialModel) {
		if (partialModel.name.charAt(0).lowerCase)
			warning(
				"Partial model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.partialModel_Name,
				UNCAPITALIZED_PARTIAL_MODEL_NAME,
				partialModel.name)
	}


	public static val INCORRECT_CLASS_NAME = ISSUE_PREFIX + "IncorrectClassName"
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
	public static val UNCAPITALIZED_CLASS_NAME = ISSUE_PREFIX + "UncapitalizedClassName"
	@Check
	def checkClassNameDoesNotStartWithLowercase (DefinedClass definedClass) {
		if (definedClass.name.charAt(0).lowerCase)
			warning(
				"Class names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.definedClass_Name,
				UNCAPITALIZED_CLASS_NAME,
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

	
}