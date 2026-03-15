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

class FormlSStateParsingTest {
	@Inject
	ParseHelper<MockUp> parseHelper
/* 	
	@Test
	def void StateTest001() {
		val result = parseHelper.parse('''
			Enumeration [a, b] A;
			Enumeration [u, v, w] U;
			Enumeration [x, B y] X;
			Enumeration [A x, B y] Y;
			Enumeration [A x, B y, X z] X;
			Enumeration [A x, B y, z] X;
			k is a;
			k is a.b;
			k is [a & b];
			k is a.[a & b];
			k is a.[a & b].b;
			k is a.[a & b].b.[a & b];
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
*/	
	
	@Test
	def void StateTest001() {
		val result = parseHelper.parse('''
			Model TestModel;
			Automaton [a, b, c] fsa;
			fsa is ¨a;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest002() {
		val result = parseHelper.parse('''
			Model TestModel;
			Automaton [a, b, c] x;
			Automaton [a, b, c] fsa;
			x is fsa¨a;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest003() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [b1, b2] B;
			Automaton [a, B b, c] fsa;
			fsa.b is ¨b2;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest004() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h] B; 
			B fsa is ¨f;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest005() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨c;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest006() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨b.g;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest007() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨[i & j & i];
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest008() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨[d1.i & d2.j & d3.i];
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest009() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨f.[k.n & l.q].f.i.[p & q];
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest009a() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨e.[k.n & l.q].i;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest009b() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨e.j.[k.n & l.q].i;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest010() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨e.[n & q];
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest011() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨[k.n & l.q].e;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest012() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨[n & q].e;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest013() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨[k.n & l.q].[k.n & l.q];
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest014() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨[n & q].[n & q];
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest015() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨[n & q].[k.n & l.q].f.m;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}
	
	@Test
	def void StateTest016() {
		val result = parseHelper.parse('''
			Model TestModel;
			Enumeration [f, g, h]   B;
			Enumeration [i, j]      D;
			Enumeration [m, n, o]   K;
			Enumeration [p, q]      L;
			Enumeration [K k & L l] E;
			Enumeration [D d1 & D d2 & D d3] F;
			Enumeration [B b, c, F d, E e] A;	
			A fsa is ¨[n & q].[k.n & l.q].e;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
	}

}