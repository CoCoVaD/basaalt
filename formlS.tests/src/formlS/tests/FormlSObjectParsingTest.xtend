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

class FormlSObjectParsingTest {
	@Inject
	ParseHelper<MockUp> parseHelper
	
	@Test
	def void ObjectTest001() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				Integer i1;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest002() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				C1 i1;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest003() {
		val result = parseHelper.parse('''
			Model TestModel begin
				main Object obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest004() {
		val result = parseHelper.parse('''
			Model TestModel begin
				external Object o1;
				constant external Object o2;
				fixed external Object o3;
				external constant Object o4;
				external fixed Object o5;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest005() {
		val result = parseHelper.parse('''
			Model TestModel begin
				common Object obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest006() {
		val result = parseHelper.parse('''
			Model TestModel begin
				private Object obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest007() {
		val result = parseHelper.parse('''
			Model TestModel begin
				constant Object obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest008() {
		val result = parseHelper.parse('''
			Model TestModel begin
				fixed Object obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest009() {
		val result = parseHelper.parse('''
			Model TestModel begin
				private Object o1;
				fixed Object o2;
				fixed private Object o3;
				common constant Object o4;
				fixed common private Object o5;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest010() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				Class C2;
				(C1, C2) obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest011() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				C1 {} obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest012() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				C1 {4} obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest013() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				C1 {@} obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest014() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				C1 {@ constant} obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest015() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				C1 {@ 5 constant} obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest016() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
				C1 {@ 5 constant} obj (Integer i);
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest017() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1 (Integer i1, Real r1);
				C1 (3, 4) {@ 5 constant} obj (Integer i);
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest018() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1 (Integer i1, Real r1);
				C1 (3, 4) {@ 5 constant} obj (Integer i, Real r);
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest019() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Integer i1 is 4;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest020() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Integer i1;
				i1 is 4;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest021() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Object obj;
				obj: Integer i1;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest022() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Object obj;
				obj begin
					Integer i1 is 4;
				end obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ObjectTest023() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Object obj begin
					Integer i1 is 4;
				end obj;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
}