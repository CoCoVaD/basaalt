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
	def void TestCheckModelExtension_01() {
		val models = parseHelper.parse('''
			Model ModelName extends ModelName;
		''')
		val name = models.models.get(0).name
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model '" + name + "'")
	}
	
	@Test
	def void TestCheckModelExtension_02() {
		val models = parseHelper.parse('''
			Model Model1 extends Model2;
			Model Model2 extends Model1;
		''')
		val name1 = models.models.get(0).name
		val name2 = models.models.get(1).name
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model '" + name1 + "'")
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model '" + name2 + "'")
	}
	
	@Test
	def void TestCheckModelExtension_03() {
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
			"Cycle in hierarchy extension of model '" + name1 + "'")
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model '" + name2 + "'")
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_MODELS,
			"Cycle in hierarchy extension of model '" + name3 + "'")
	}
	
	@Test
	def void TestCheckClassExtension_01() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Class Class1 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val definedClass = model.statements.get(0).definedClass
		val name = definedClass.name
		models.assertError (
			FormlPackage.eINSTANCE.definedClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class '" + name + "'")
	}
	
	@Test
	def void TestCheckClassExtension_02() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Class Class1 extends Class2;
				Class Class2 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val definedClass1 = model.statements.get(0).definedClass
		val definedClass2 = model.statements.get(1).definedClass
		val name1 = definedClass1.name
		val name2 = definedClass2.name
		models.assertError (
			FormlPackage.eINSTANCE.definedClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class '" + name1 + "'")
		models.assertError (
			FormlPackage.eINSTANCE.definedClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class '" + name2 + "'")
	}
	
	@Test
	def void TestCheckClassExtension_03() {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Class Class1 extends Class2;
				Class Class2 extends Class3;
				Class Class3 extends Class1;
			end ModelName;
		''')
		val model = models.models.get(0)
		val definedClass1 = model.statements.get(0).definedClass
		val definedClass2 = model.statements.get(1).definedClass
		val definedClass3 = model.statements.get(2).definedClass
		val name1 = definedClass1.name
		val name2 = definedClass2.name
		val name3 = definedClass3.name
		models.assertError (
			FormlPackage.eINSTANCE.definedClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class '" + name1 + "'")
		models.assertError (
			FormlPackage.eINSTANCE.definedClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class '" + name2 + "'")
		models.assertError (
			FormlPackage.eINSTANCE.definedClass,
			FormlExtensionValidator.CYCLE_WITH_EXTENDED_CLASSES,
			"Cycle in hierarchy extension of class '" + name3 + "'")
	}
}