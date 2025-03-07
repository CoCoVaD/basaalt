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
				Section PartialModelName begin end;
			end ModelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.section,
			FormlEndNameValidator.NO_SECTION_END_NAME,
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
			FormlPackage.eINSTANCE.simpleClass,
			FormlEndNameValidator.NO_CLASS_END_NAME,
			"No end name"
		)
	}
	
	@Test
	def void TestEnumerationEndNameExists () {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Enumeration [s1, s2] EnumerationName begin end;
			end ModelName;
		''')
		models.assertWarning (
			FormlPackage.eINSTANCE.enumeration,
			FormlEndNameValidator.NO_ENUMERATION_END_NAME,
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
				Section PartialModelName begin end OtherName;
			end ModelName;
		''')
		val model = models.models.get(0)
		val section = model.statements.get(0).section
		val name = section.name
		val endName = section.endName
		models.assertError (
			FormlPackage.eINSTANCE.section,
			FormlEndNameValidator.INCORRECT_SECTION_END_NAME,
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
		val definedClass = model.statements.get(0).simpleClass
		val name = definedClass.name
		val endName = definedClass.endName
		models.assertError (
			FormlPackage.eINSTANCE.simpleClass,
			FormlEndNameValidator.INCORRECT_CLASS_END_NAME,
			"End name " + endName +" different from name " + name
		)
	}
	
	@Test
	def void TestEnumerationEndName () {
		val models = parseHelper.parse('''
			Model ModelName begin 
				Enumeration [s1, s2] EnumerationName begin end OtherName;
			end ModelName;
		''')
		val model = models.models.get(0)
		val enumeration = model.statements.get(0).enumeration
		val name = enumeration.name
		val endName = enumeration.endName
		models.assertError (
			FormlPackage.eINSTANCE.enumeration,
			FormlEndNameValidator.INCORRECT_ENUMERATION_END_NAME,
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