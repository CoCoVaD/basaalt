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

class FormlSContractParsingTest {
	@Inject
	ParseHelper<MockUp> parseHelper
	
	@Test
	def void ContractTest001() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Contract contr (A, c);
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ContractTest002() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Contract contr (A, c) begin
					A begin
						Guarantee g1;
					end A;
					c begin
						Integer i;
					end c;
				end;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ContractTest003() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Contract mainPower (mps) begin
					mps: Guarantee g1;
				end mainPower;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ContractTest004() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Contract mainPower (mps) begin
					mps: Guarantee g1;
				end mainPower;
				acknowledged mainPower;
			end;
			
			acknowledged mainPower;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void EncroachmentTest001() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Encroachment sideEffect (A, c);
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
}