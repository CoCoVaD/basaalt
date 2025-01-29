package forml.tests

// 29 January 2025

import com.google.inject.Inject
import forml.forml.FormlPackage
import forml.forml.Models
import forml.validation.FormlEndNameValidator
import forml.validation.FormlNameValidator
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

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
	def void TestCheckModelEndName() {
		val models = parseHelper.parse('''
			Model ModelName begin end OtherName;
		''')
		val name = models.models.get(0).name
		val endName = models.models.get(0).endName
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlEndNameValidator.INCORRECT_MODEL_END_NAME,
			"End name (" + endName +") different from name (" + name +")"
		)
	}
	
}