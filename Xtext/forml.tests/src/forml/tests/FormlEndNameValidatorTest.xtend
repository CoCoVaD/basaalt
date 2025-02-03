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
import forml.validation.FormlEndNameValidator

@ExtendWith(InjectionExtension)
@InjectWith(FormlInjectorProvider)

class FormlEndNameValidatorTest {
	@Inject
	ParseHelper<Models> parseHelper
	@Inject extension ValidationTestHelper
	
	@Test
	def void TestModelEndNameExists () {
		val models = parseHelper.parse('''
			Model ModelName begin end;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.model,
			FormlEndNameValidator.NO_MODEL_END_NAME,
			"No end name"
		)
	}
	
	@Test
	def void TestPartialModelEndNameExists () {
		val models = parseHelper.parse('''
			Model ModelName begin 
				partial Model PartialModelName begin end;
			end ModelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.partialModel,
			FormlEndNameValidator.NO_PARTIAL_MODEL_END_NAME,
			"No end name"
		)
	}
	
	@Test
	def void TestClassEndNameExists () {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Class ClassName begin end;
			end ModelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.definedClass,
			FormlEndNameValidator.NO_CLASS_END_NAME,
			"No end name"
		)
	}
	
	@Test
	def void TestObjectEndNameExists () {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Object objectName begin end;
			end ModelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.object,
			FormlEndNameValidator.NO_OBJECT_END_NAME,
			"No end name"
		)
	}

	@Test
	def void TestModelEndName () {
		val models = parseHelper.parse('''
			Model ModelName begin end OtherName;
		''')
		val name = models.models.get(0).name
		val endName = models.models.get(0).endName
		models.assertError (
			FormlPackage.eINSTANCE.model,
			FormlEndNameValidator.INCORRECT_MODEL_END_NAME,
			"End name " + endName +" different from name " + name
		)
	}
	
	@Test
	def void TestPartialModelEndName () {
		val models = parseHelper.parse('''
			Model ModelName begin 
				partial Model PartialModelName begin end OtherName;
			end ModelName;
		''')
		val model = models.models.get(0)
		val partialModel = model.statements.get(0).partialModel
		val name = partialModel.name
		val endName = partialModel.endName
		models.assertError (
			FormlPackage.eINSTANCE.partialModel,
			FormlEndNameValidator.INCORRECT_PARTIAL_MODEL_END_NAME,
			"End name " + endName +" different from name " + name
		)
	}
	
	@Test
	def void TestClassEndName () {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Class ClassName begin end OtherName;
			end ModelName;
		''')
		val model = models.models.get(0)
		val definedClass = model.statements.get(0).definedClass
		val name = definedClass.name
		val endName = definedClass.endName
		models.assertError (
			FormlPackage.eINSTANCE.definedClass,
			FormlEndNameValidator.INCORRECT_CLASS_END_NAME,
			"End name " + endName +" different from name " + name
		)
	}
	
	@Test
	def void TestObjectEndName () {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Object objectName begin end otherName;
			end ModelName;
		''')
		val model = models.models.get(0)
		val object = model.statements.get(0).object
		val name = object.name
		val endName = object.endName
		models.assertError (
			FormlPackage.eINSTANCE.object,
			FormlEndNameValidator.INCORRECT_OBJECT_END_NAME,
			"End name " + endName +" different from name " + name
		)
	}
}	