package forml.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import forml.forml.Models

@ExtendWith(InjectionExtension)
@InjectWith(FormlInjectorProvider)

class FormlEnumerationParsingTest {
	@Inject
	ParseHelper<Models> parseHelper
	
	@Test
	def void EnumerationTest01() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Enumeration [s1, s2] Enum;
			end TestModel;
			''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void EnumerationTest02() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Enumeration [s1, s2, s3] Enum;
			end TestModel;
			''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void EnumerationTest03() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Enumeration [[k1, k2] s1, s2, s3] Enum;
			end TestModel;
			''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void EnumerationTest04() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Enumeration [x1, x2] X;
				Enumeration [[k1, k2] s1, X s2, s3] Enum;
			end TestModel;
			''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void EnumerationTest05() {
		val result = parseHelper.parse('''
			Model TestModel begin
				Enumeration [f, g, h]   B;
				Enumeration [i, j]      D;
				Enumeration [m, n, o]   K;
				Enumeration [p, q]      L;
				Enumeration [K k & L l] E;
				Enumeration [B b, c, [D d1 & D d2 & D d3] d, E e] A;
			end TestModel;
			''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
}	
