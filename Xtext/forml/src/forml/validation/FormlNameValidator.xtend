package forml.validation

import org.eclipse.xtext.validation.Check
import static extension java.lang.Character.*

import forml.forml.FormlPackage
import forml.validation.FormlValidator
import forml.forml.Model
import forml.forml.Section
import forml.forml.SimpleClass
import forml.forml.Enumeration
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
				FormlPackage.eINSTANCE.name_Name,
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
				FormlPackage.eINSTANCE.name_Name,
				MODEL_NAME_FIRST_CHAR_IS_DEGREE,
				model.name)
	}

	public static val UNCAPITALIZED_MODEL_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedModelName"
	@Check
	def checkModelNameDoesNotStartsWithLowerCase (Model model) {
		if (model.name.charAt(0).lowerCase)
			warning(
				"Model names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.name_Name,
				UNCAPITALIZED_MODEL_NAME,
				model.name)
	}

	public static val INCORRECT_SECTION_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectSectionName"
	@Check
	def checkPartialModelNameIsNotDegree (Section partialModel) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (partialModel.name.charAt(0) == degree && partialModel.name.length == 1)
			warning(
				"Sections should not be named °", 
				FormlPackage.eINSTANCE.name_Name,
				INCORRECT_SECTION_NAME,
				partialModel.name)
	}

	public static val SECTION_NAME_FIRST_CHAR_IS_DEGREE = FormlValidator.ISSUE_PREFIX + "SectionNameFirstCharIsDegree"
	@Check
	def checkPartialModelNameDoesNotStartsWithDegree (Section partialModel) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (partialModel.name.charAt(0) == degree && partialModel.name.length > 1)
			warning(
				"Section names should not begin with a °", 
				FormlPackage.eINSTANCE.name_Name,
				SECTION_NAME_FIRST_CHAR_IS_DEGREE,
				partialModel.name)
	}

	public static val UNCAPITALIZED_SECTION_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedSectionName"
	@Check
	def checkPartialModelNameDoesNotStartWithLowerCase (Section section) {
		if (section.name.charAt(0).lowerCase)
			warning(
				"Section names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.name_Name,
				UNCAPITALIZED_SECTION_NAME,
				section.name)
	}

	public static val INCORRECT_CLASS_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectClassName"
	@Check
	def checkClassNameIsNotDegree (SimpleClass simpleClass) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (simpleClass.name.charAt(0) == degree && simpleClass.name.length == 1)
			warning(
				"Classes should not be named °", 
				FormlPackage.eINSTANCE.name_Name,
				INCORRECT_CLASS_NAME,
				simpleClass.name)
	}

	public static val CLASS_NAME_FIRST_CHAR_IS_DEGREE = FormlValidator.ISSUE_PREFIX + "ClassNameFirstCharIsDegree"
	@Check
	def checkClassNameDoesNotStartsWithDegree (SimpleClass simpleClass) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (simpleClass.name.charAt(0) == degree && simpleClass.name.length > 1)
			warning(
				"Class names should not begin with a °", 
				FormlPackage.eINSTANCE.name_Name,
				CLASS_NAME_FIRST_CHAR_IS_DEGREE,
				simpleClass.name)
	}
	
	public static val UNCAPITALIZED_CLASS_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedClassName"
	@Check
	def checkClassNameDoesNotStartWithLowerCase (SimpleClass simpleClass) {
		if (simpleClass.name.charAt(0).lowerCase)
			warning(
				"Class names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.name_Name,
				UNCAPITALIZED_CLASS_NAME,
				simpleClass.name)
	}

	public static val INCORRECT_ENUMERATION_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectEnumerationName"
	@Check
	def checkEnumerationNameIsNotDegree (Enumeration enumeration) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (enumeration.name.charAt(0) == degree && enumeration.name.length == 1)
			warning(
				"Enumerations should not be named °", 
				FormlPackage.eINSTANCE.name_Name,
				INCORRECT_ENUMERATION_NAME,
				enumeration.name)
	}

	public static val ENUMERATION_NAME_FIRST_CHAR_IS_DEGREE = FormlValidator.ISSUE_PREFIX + "EnumerationNameFirstCharIsDegree"
	@Check
	def checkEnumerationNameDoesNotStartsWithDegree (Enumeration enumeration) {
		val char degree = '°'	// This is necessary to prevent conversion of char literals into strings
		if (enumeration.name.charAt(0) == degree && enumeration.name.length > 1)
			warning(
				"Enumeration names should not begin with a °", 
				FormlPackage.eINSTANCE.name_Name,
				ENUMERATION_NAME_FIRST_CHAR_IS_DEGREE,
				enumeration.name)
	}
	
	public static val UNCAPITALIZED_ENUMERATION_NAME = FormlValidator.ISSUE_PREFIX + "UncapitalizedEnumerationName"
	@Check
	def checkEnumerationNameDoesNotStartWithLowerCase (Enumeration enumeration) {
		if (enumeration.name.charAt(0).lowerCase)
			warning(
				"Enumeration names should not begin with a lower case letter", 
				FormlPackage.eINSTANCE.name_Name,
				UNCAPITALIZED_ENUMERATION_NAME,
				enumeration.name)
	}

	public static val CAPITALIZED_OBJECT_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectObjectName"
	@Check
	def checkObjectNameDoesNotStartsWithUpperCase (Object object) {
		if (object.name.charAt(0).upperCase)
			warning(
				"Object names should not begin with an upper case letter", 
				FormlPackage.eINSTANCE.name_Name,
				CAPITALIZED_OBJECT_NAME,
				object.name)
	}
}