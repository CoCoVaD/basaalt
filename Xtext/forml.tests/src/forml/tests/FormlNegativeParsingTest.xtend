package forml.tests

// 29 January 2025

import com.google.inject.Inject
import forml.forml.Models
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

@ExtendWith(InjectionExtension)
@InjectWith(FormlInjectorProvider)

class FormlNegativeParsingTest {
	@Inject
	ParseHelper<Models> parseHelper
	
	@Test
	def void NegativeTest01_01() {
		val result = parseHelper.parse('''
			Model TestModel
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(!errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
}