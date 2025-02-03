package forml.tests

// 29 January 2025

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import forml.forml.FormlPackage
import forml.forml.Models
import forml.validation.FormlNameValidator

@ExtendWith(InjectionExtension)
@InjectWith(FormlInjectorProvider)

class FormlNameValidatorTest {
	@Inject
	ParseHelper<Models> parseHelper
	@Inject extension ValidationTestHelper
	
	/*
	 * Model names
	 */
	@Test
	def void TestModelNameIsNotDegree () {
		val models = parseHelper.parse('''
			Model °;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.model,
			FormlNameValidator.INCORRECT_MODEL_NAME,
			"Models should not be named °"
		)
	}
	
	@Test
	def void TestModelNameFirstCharIsNotDegree () {
		val models = parseHelper.parse('''
			Model °ModelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.model,
			FormlNameValidator.MODEL_NAME_FIRST_CHAR_IS_DEGREE,
			"Model names should not begin with a °"
		)
	}
	
	@Test
	def void TestModelNameFirstCharIsNotLowerCase () {
		val models = parseHelper.parse('''
			Model modelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.model,
			FormlNameValidator.UNCAPITALIZED_MODEL_NAME,
			"Model names should not begin with a lower case letter"
		)
	}
	
	/*
	 * Partial model names
	 */
	@Test
	def void TestPartialModelNameIsNotDegree () {
		val models = parseHelper.parse('''
			Model TestModel begin
				partial Model °;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.partialModel,
			FormlNameValidator.INCORRECT_PARTIAL_MODEL_NAME,
			"Partial models should not be named °"
		)
	}
	
	@Test
	def void TestPartialModelNameFirstCharIsNotDegree () {
		val models = parseHelper.parse('''
			Model TestModel begin
				partial Model °PartialModelName;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.partialModel,
			FormlNameValidator.PARTIAL_MODEL_NAME_FIRST_CHAR_IS_DEGREE,
			"Partial model names should not begin with a °"
		)
	}
	@Test
	def void TestPartialkModelNameFirstCharIsNotLowerCase () {
		val models = parseHelper.parse('''
			Model TestModel begin
				partial Model partialModelName;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.partialModel,
			FormlNameValidator.UNCAPITALIZED_PARTIAL_MODEL_NAME,
			"Partial model names should not begin with a lower case letter"
		)
	}
	
	/*
	 * Class names
	 */
	@Test
	def void TestClassNameIsNotDegree () {
		val models = parseHelper.parse('''
			Model TestModel begin
				Class °;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.definedClass,
			FormlNameValidator.INCORRECT_CLASS_NAME,
			"Classes should not be named °"
		)
	}
	
	@Test
	def void TestClassNameFirstCharIsNotDegree () {
		val models = parseHelper.parse('''
			Model TestModel begin
				Class °ClassName;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.definedClass,
			FormlNameValidator.CLASS_NAME_FIRST_CHAR_IS_DEGREE,
			"Class names should not begin with a °"
		)
	}
	
	@Test
	def void TestClassNameFirstCharIsNotLowerCase () {
		val models = parseHelper.parse('''
			Model TestModel begin
				Class className;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.definedClass,
			FormlNameValidator.UNCAPITALIZED_CLASS_NAME,
			"Class names should not begin with a lower case letter"
		)
	}
	
	/*
	 * Object names
	 */
	@Test
	def void TestObjectNameFirstCharIsNotUpperCase_01 () {
		val models = parseHelper.parse('''
			Model TestModel begin
				Integer Int;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.object,
			FormlNameValidator.CAPITALIZED_OBJECT_NAME,
			"Object names should not begin with an upper case letter"
		)
	}
	
	@Test
	def void TestObjectNameFirstCharIsNotUpperCase_02 () {
		val models = parseHelper.parse('''
			Model TestModel begin
				Class DefinedClass;
				DefinedClass Instance;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.object,
			FormlNameValidator.CAPITALIZED_OBJECT_NAME,
			"Object names should not begin with an upper case letter"
		)
	}
}