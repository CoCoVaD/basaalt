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
	
	@Test
	def void TestCheckModelNameStartsWithUppercase_01() {
		val models = parseHelper.parse('''
			Model °ModelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.model,
			FormlNameValidator.INCORRECT_MODEL_NAME,
			"Model names should begin neither with a ° nor with an _"
		)
	}
	
	@Test
	def void TestCheckModelNameStartsWithUppercase_02() {
		val models = parseHelper.parse('''
			Model _ModelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.model,
			FormlNameValidator.INCORRECT_MODEL_NAME,
			"Model names should begin neither with a ° nor with an _"
		)
	}
	
	@Test
	def void TestCheckModelNameStartsWithUppercase_03() {
		val models = parseHelper.parse('''
			Model modelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.model,
			FormlNameValidator.UNCAPITALIZED_MODEL_NAME,
			"Model names should not begin with a lower case letter"
		)
	}
	
	@Test
	def void TestCheckPartialModelNameStartsWithUppercase_01() {
		val models = parseHelper.parse('''
			Model TestModel begin
				partial Model °PartialModelName;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.partialModel,
			FormlNameValidator.INCORRECT_PARTIAL_MODEL_NAME,
			"Partial model names should begin neither with a ° nor with an _"
		)
	}
	
	@Test
	def void TestCheckPartialModelNameStartsWithUppercase_02() {
		val models = parseHelper.parse('''
			Model TestModel begin
				partial Model _PartialModelName;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.partialModel,
			FormlNameValidator.INCORRECT_PARTIAL_MODEL_NAME,
			"Partial model names should begin neither with a ° nor with an _"
		)
	}
	
	@Test
	def void TestCheckPartialkModelNameStartsWithUppercase_03() {
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
	
	@Test
	def void TestCheckClassNameStartsWithUppercase_01() {
		val models = parseHelper.parse('''
			Model TestModel begin
				Class °ClassName;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.definedClass,
			FormlNameValidator.INCORRECT_CLASS_NAME,
			"Class names should begin neither with a ° nor with an _"
		)
	}
	
	@Test
	def void TestCheckClassNameStartsWithUppercase_02() {
		val models = parseHelper.parse('''
			Model TestModel begin
				Class _ClassName;
			end TestModel;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.definedClass,
			FormlNameValidator.INCORRECT_CLASS_NAME,
			"Class names should begin neither with a ° nor with an _"
		)
	}
	
	@Test
	def void TestCheckClassNameStartsWithUppercase_03() {
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
	
	@Test
	def void TestCheckObjectNameStartsWithUppercase_01() {
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
	def void TestCheckObjectNameStartsWithUppercase_02() {
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