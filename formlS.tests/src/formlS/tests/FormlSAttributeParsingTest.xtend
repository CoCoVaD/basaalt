package formlS.tests

import com.google.inject.Inject
import formlS.formlS.MockUp
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

@ExtendWith(InjectionExtension)
@InjectWith(FormlSInjectorProvider)

class FormlSAttributeParsingTest {
	@Inject
	ParseHelper<MockUp> parseHelper
	
	@Test
	def void AttributeTest001() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real x2 is derivative;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void AttributeTest002() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real x2 is derivative[2];
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void AttributeTest003() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real x2 is eViolation.rate;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
}