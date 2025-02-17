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
import forml.validation.FormlExtensionValidator

@ExtendWith(InjectionExtension)
@InjectWith(FormlInjectorProvider)

class FormlExtensionValidatorTest {
	@Inject
	ParseHelper<Models> parseHelper
	@Inject extension ValidationTestHelper
	
	@Test
	def void TestModelExtension_01() {
		val models = parseHelper.parse('''
			Model ModelName extends ModelName;
		''')
		val name = models.models.get(0).name
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model " + name)
	}
	
	@Test
	def void TestModelExtension_02() {
		val models = parseHelper.parse('''
			Model Model1 extends Model2;
			Model Model2 extends Model1;
		''')
		val name1 = models.models.get(0).name
		val name2 = models.models.get(1).name
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model " + name1)
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model " + name2)
	}
	
	@Test
	def void TestModelExtension_03() {
		val models = parseHelper.parse('''
			Model Model1 extends Model2;
			Model Model2 extends Model3;
			Model Model3 extends Model1;
		''')
		val name1 = models.models.get(0).name
		val name2 = models.models.get(1).name
		val name3 = models.models.get(2).name
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model " + name1)
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model " + name2)
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model " + name3)
	}
	
	@Test
	def void TestClassExtension_01() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Class Class1 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val statement = model.statements.get(0)
		val name = statement.simpleClass.name
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class " + name)
	}
	
	@Test
	def void TestClassExtension_02() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Class Class1 extends Class2;
				Class Class2 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val statement1 = model.statements.get(0)
		val statement2 = model.statements.get(1)
		val name1 = statement1.simpleClass.name
		val name2 = statement2.simpleClass.name
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class " + name1)
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class " + name2)
	}
	
	@Test
	def void TestClassExtension_03() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Class Class1 extends Class2;
				Class Class2 extends Class3;
				Class Class3 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val statement1 = model.statements.get(0)
		val statement2 = model.statements.get(1)
		val statement3 = model.statements.get(2)
		val name1 = statement1.simpleClass.name
		val name2 = statement2.simpleClass.name
		val name3 = statement3.simpleClass.name
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class " + name1)
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class " + name2)
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class " + name3)
	}
	
	@Test
	def void TestEnumerationExtension_01() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Enumeration [s1, s2] Class1 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val statement = model.statements.get(0)
		val name = statement.enumeration.name
		models.assertError (
			FormlPackage.eINSTANCE.enumeration,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of enumeration " + name)
	}
	
	@Test
	def void TestEnumerationExtension_02() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Enumeration [s1, s2] Class1 extends Class2;
				Class Class2 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val statement1 = model.statements.get(0)
		val statement2 = model.statements.get(1)
		val name1 = statement1.enumeration.name
		val name2 = statement2.simpleClass.name
		models.assertError (
			FormlPackage.eINSTANCE.enumeration,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of enumeration " + name1)
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class " + name2)
	}
	
	@Test
	def void TestEnumerationExtension_03() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Enumeration [s1, s2] Class1 extends Class2;
				Class Class2 extends Class3;
				Enumeration [s3, s4] Class3 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val statement1 = model.statements.get(0)
		val statement2 = model.statements.get(1)
		val statement3 = model.statements.get(2)
		val name1 = statement1.enumeration.name
		val name2 = statement2.simpleClass.name
		val name3 = statement3.enumeration.name
		models.assertError (
			FormlPackage.eINSTANCE.enumeration,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of enumeration " + name1)
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class " + name2)
		models.assertError (
			FormlPackage.eINSTANCE.enumeration,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of enumeration " + name3)
	}
}