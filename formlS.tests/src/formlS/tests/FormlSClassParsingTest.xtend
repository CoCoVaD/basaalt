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

class FormlSClassParsingTest {
	@Inject
	ParseHelper<MockUp> parseHelper
	
	@Test
	def void ClassTest001() {
		val result = parseHelper.parse('''
			Model TestModel :
				Class C1;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest002() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Class C1;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest003() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract Class C1;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest004() {
		val result = parseHelper.parse('''
			Model TestModel begin
				main Class C1;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest005() {
		val result = parseHelper.parse('''
			Model TestModel begin
				main Class C1;
				external Class C2;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest006() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external Class C2;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest007() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest008() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest009() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends C2;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest009a() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends Integer;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest010() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends C1, Boolean;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest011() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 "Comment 1" "Comment" extends C1, C2 "Comment 3" "Comment 4";
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest012() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 (C1 c1) extends C1, C2;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest013() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 (C1 c1, C2 c2) extends C1, C2;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest014() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 (C1 c1 "Comment 1", C2 c2 "Comment 2" "Comment 3") extends C1, C2;
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest015() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends C2 {};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest016() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends Integer ${};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest017() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3  extends Integer {4};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest018() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends Integer {4..6};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest019() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends Integer {#};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest020() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends Integer {4..5 @};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest021() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends Integer {! 4..6};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest022() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends Integer {! 4..6 fixed};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest023() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 extends Integer {! constant 4..6};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest024() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 {3} extends Integer {#};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest025() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 ${} extends Integer {4..% @};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest026() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 {fixed} extends Integer {! 4..6};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest027() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 {@} extends Integer {! 4..6 fixed};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
		
	@Test
	def void ClassTest028() {
		val result = parseHelper.parse('''
			Model TestModel begin
				abstract main Class C1;
				external abstract Class C2;
				private Class C3 ${2..%} extends Integer {! constant 4..6};
			end TestModel;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest029() {
		val result = parseHelper.parse('''
			Model TestModel :
				Class C1 (Event e1);
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest030() {
		val result = parseHelper.parse('''
			Model TestModel :
				Class C1 (Event e1, Integer i1);
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest031() {
		val result = parseHelper.parse('''
			Model TestModel :
				Class C1 (Integer i1);
				Class C2 extends C1 (3);
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void ClassTest032() {
		val result = parseHelper.parse('''
			Model TestModel :
				Class C1 begin
					Integer i1;
				end C1;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void EnumerationTest001() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Enumeration [f, g, h] B;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void EnumerationTest002() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Enumeration [f, g, h]   B;
				Enumeration [i, j]      D;
				Enumeration [m, n, o]   K;
				Enumeration [p, q]      L;
				Enumeration [K k & L l] E;    // Cartesian product of k and l
				Enumeration [B b, c, [D d1 & D d2 & D d3] d, E e] A;	
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
}