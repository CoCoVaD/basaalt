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

class FormlSNumberParsingTest {
	@Inject
	ParseHelper<MockUp> parseHelper
	
	@Test
	def void NumberTest001() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r1 is 4;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	
	@Test
	def void NumberTest002() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r1 is 4;
			Real r2 is 5.;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void NumberTest003() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r3 is 4.2;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void NumberTest004() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r4 is 4e2;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void NumberTest005() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r5 is 4e-3;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void NumberTest006() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r6 is 4.e5;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void NumberTest007() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r7 is 4.56e-4;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void NumberTest008() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r8 is .e6;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void NumberTest009() {
		val result = parseHelper.parse('''
			Model TestModel;
			Real r9 is 4E2;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
}