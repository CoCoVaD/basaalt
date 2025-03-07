package forml.validation

import org.eclipse.xtext.validation.Check

import forml.forml.FormlPackage
import forml.validation.FormlValidator
import forml.forml.Model
import forml.forml.Section
import forml.forml.SimpleClass
import forml.forml.Enumeration
import forml.forml.Object
import forml.forml.Definition

class FormlEndNameValidator extends AbstractFormlValidator {
/**
 * No end name
 *
 */
	public static val NO_MODEL_END_NAME = FormlValidator.ISSUE_PREFIX + "NoModelEndName"
	@Check
	def checkModelEndNameExists(Model model) {
		if (model.blockEnd)
			if (model.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					NO_MODEL_END_NAME,
					model.name)
	}
	
	public static val NO_SECTION_END_NAME = FormlValidator.ISSUE_PREFIX + "NoSectionEndName"
	@Check
	def checkPartialModelEndNameExists(Section section) {
		if (section.blockEnd)
			if (section.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					NO_SECTION_END_NAME,
					section.name)
	}
	
	public static val NO_CLASS_END_NAME = FormlValidator.ISSUE_PREFIX + "NoClassEndName"
	@Check
	def checkClassEndNameExists(SimpleClass simpleClass) {
		if (simpleClass.blockEnd)
			if (simpleClass.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					NO_CLASS_END_NAME,
					simpleClass.name)
	}
	
	public static val NO_ENUMERATION_END_NAME = FormlValidator.ISSUE_PREFIX + "NoEnumerationEndName"
	@Check
	def checkEnumerationEndNameExists(Enumeration enumeration) {
		if (enumeration.blockEnd)
			if (enumeration.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					NO_ENUMERATION_END_NAME,
					enumeration.name)
	}
	
	public static val NO_OBJECT_END_NAME = FormlValidator.ISSUE_PREFIX + "NoObjectEndName"
	@Check
	def checkObjectEndNameExists(Object object) {
		if (object.blockEnd)
			if (object.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					NO_OBJECT_END_NAME,
					object.name)
	}
	
	public static val NO_DEFINITION_END_NAME = FormlValidator.ISSUE_PREFIX + "NoDefinitionEndName"
	@Check
	def checkDefinitionEndNameExists(Definition definition) {
		val reference = definition.item
		val name = switch reference {
			Model:        reference.name
			Section:      reference.name
			SimpleClass:  reference.name
			Enumeration:  reference.name
			Object:       reference.name
		}
		if (definition.blockEnd)
			if (definition.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					NO_DEFINITION_END_NAME,
					name)
	}

/**
 * End name different from name 
 *
 */
	public static val INCORRECT_MODEL_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectModelEndName"
	@Check
	def checkModelEndName(Model model) {
		if (model.blockEnd) {
			val name = model.name
			val endName = model.endName
			if (model.endName != name)
				error(
					"End name " + endName + " different from name " + name, 
					FormlPackage.eINSTANCE.itemizedDefinition_EndName,
					INCORRECT_MODEL_END_NAME,
					name,
					endName)
		}			
	}

	public static val INCORRECT_SECTION_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectSectionEndName"
	@Check
	def checkPartialModelEndName(Section section) {
		if (section.blockEnd)
			if (section.endName != section.name)
				error(
					"End name " + section.endName + " different from name " + section.name, 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					INCORRECT_SECTION_END_NAME,
					section.name,
					section.endName)
	}

	public static val INCORRECT_CLASS_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectClassEndName"
	@Check
	def checkClassEndName(SimpleClass simpleClass) {
		if (simpleClass.blockEnd)
			if (simpleClass.endName != simpleClass.name)
				error(
					"End name " + simpleClass.endName + " different from name " + simpleClass.name, 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					INCORRECT_CLASS_END_NAME,
					simpleClass.name,
					simpleClass.endName)
	}

	public static val INCORRECT_ENUMERATION_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectEnumerationEndName"
	@Check
	def checkEnumerationEndName(Enumeration enumeration) {
		if (enumeration.blockEnd)
			if (enumeration.endName != enumeration.name)
				error(
					"End name " + enumeration.endName + " different from name " + enumeration.name, 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					INCORRECT_ENUMERATION_END_NAME,
					enumeration.name,
					enumeration.endName)
	}

	public static val INCORRECT_OBJECT_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectObjectEndName"
	@Check
	def checkOjectEndName(Object object) {
		if (object.blockEnd)
			if (object.endName != object.name)
				error(
					"End name " + object.endName + " different from name " + object.name, 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					INCORRECT_OBJECT_END_NAME,
					object.name,
					object.endName)
	}

	public static val INCORRECT_DEFINITION_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectDefinitionEndName"
	@Check
	def checkDefinitionEndName(Definition definition) {
		val reference = definition.item
		val name = switch reference {
			Model:        reference.name
			Section:      reference.name
			SimpleClass:  reference.name
			Enumeration:  reference.name
			Object:       reference.name
		}
		if (definition.blockEnd)
			if (definition.endName != name)
				error(
					"End name " + definition.endName + " different from name " + name, 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					INCORRECT_DEFINITION_END_NAME,
					name,
					definition.endName)
	}
}