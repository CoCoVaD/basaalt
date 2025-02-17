package forml.validation

// 29 January 2025

import org.eclipse.xtext.validation.Check

import forml.forml.FormlPackage
import forml.validation.FormlValidator
import forml.forml.Model
import forml.forml.PartialModel
import forml.forml.SimpleClass
import forml.forml.Enumeration
import forml.forml.Object

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
	
	public static val NO_PARTIAL_MODEL_END_NAME = FormlValidator.ISSUE_PREFIX + "NoPartialModelEndName"
	@Check
	def checkPartialModelEndNameExists(PartialModel partialModel) {
		if (partialModel.blockEnd)
			if (partialModel.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					NO_PARTIAL_MODEL_END_NAME,
					partialModel.name)
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

	public static val INCORRECT_PARTIAL_MODEL_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectPartialModelEndName"
	@Check
	def checkPartialModelEndName(PartialModel partialModel) {
		if (partialModel.blockEnd)
			if (partialModel.endName != partialModel.name)
				error(
					"End name " + partialModel.endName + " different from name " + partialModel.name, 
					FormlPackage.eINSTANCE.itemizedDefinition_BlockEnd,
					INCORRECT_PARTIAL_MODEL_END_NAME,
					partialModel.name,
					partialModel.endName)
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
}