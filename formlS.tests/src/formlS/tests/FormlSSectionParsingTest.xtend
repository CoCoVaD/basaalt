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

class FormlSSectionParsingTest {
	@Inject
	ParseHelper<MockUp> parseHelper
	
	@Test
	def void SectionTest001() {
		val result = parseHelper.parse('''
			Model TestModel : Section PartA;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest002() {
		val result = parseHelper.parse('''
			Model TestModel : Section PartA begin
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest003() {
		val result = parseHelper.parse('''
			Model TestModel : Section PartA begin
				Integer a;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest004f() {
		val result = parseHelper.parse('''
			Model TestModel : Section PartA begin
				Integer a is 10;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest005() {
		val result = parseHelper.parse('''
			Model TestModel : Section PartA begin
				Integer #a is 10;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest006() {
		val result = parseHelper.parse('''
			Model TestModel : Section PartA begin
				@a is 10;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest007() {
		val result = parseHelper.parse('''
			Model TestModel : Section PartA begin
				@a is 10;
				Section PartAA;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest008() {
		val result = parseHelper.parse('''
			Model TestModel : Section PartA begin
				@a is 10;
				Section PartAA begin
				end PartAA;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest009() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Section PartA begin
					Integer a is 10;
				end PartA;
			end testModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest010() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Section PartA begin
					Integer a is 10;
				end PartA;
			end testModel;
			
			PartA begin
				Boolean b;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest011() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Section PartA begin
					Integer a is 10;
				end PartA;
			end testModel;
			
			refined PartA begin
				Boolean b;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest012() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Section PartA begin
					Integer a is 10;
				end PartA;
			end testModel;
			
			refined PartA;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void SectionTest013() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Section PartA;
			end testModel;
			
			PartA begin
				Boolean b;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
}