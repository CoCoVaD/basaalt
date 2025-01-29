package forml.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import forml.forml.FormlPackage
import forml.forml.Models
import forml.validation.FormlValidator

@ExtendWith(InjectionExtension)
@InjectWith(FormlInjectorProvider)

class FormlValidatorTest {
	@Inject
	ParseHelper<Models> parseHelper
	@Inject extension ValidationTestHelper
	
	@Test
	def void TestCheckModelEndName() {
		val models = parseHelper.parse('''
			Model ModelName begin end OtherName;
		''')
		val name = models.models.get(0).name
		val endName = models.models.get(0).endName
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlValidator.INCORRECT_MODEL_END_NAME,
			"End name (" + endName +") different from name (" + name +")"
		)
	}
}