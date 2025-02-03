package forml.validation

// 29 January 2025

import org.eclipse.xtext.validation.Check

import forml.forml.FormlPackage
import forml.validation.FormlValidator
import forml.forml.Model
import forml.forml.PartialModel
import forml.forml.DefinedClass
import forml.forml.Object

class FormlEndNameValidator extends AbstractFormlValidator {
/**
 * No end name
 *
 */
	public static val NO_MODEL_END_NAME = FormlValidator.ISSUE_PREFIX + "NoModelEndName"
	@Check
	def checkModelEndNameExists(Model model) {
		if (model.block)
			if (model.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.model_BlockEnd,
					NO_MODEL_END_NAME,
					model.name)
	}
	
	public static val NO_PARTIAL_MODEL_END_NAME = FormlValidator.ISSUE_PREFIX + "NoPartialModelEndName"
	@Check
	def checkPartialModelEndNameExists(PartialModel partialModel) {
		if (partialModel.block)
			if (partialModel.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.partialModel_BlockEnd,
					NO_PARTIAL_MODEL_END_NAME,
					partialModel.name)
	}
	
	public static val NO_CLASS_END_NAME = FormlValidator.ISSUE_PREFIX + "NoClassEndName"
	@Check
	def checkClassEndNameExists(DefinedClass definedClass) {
		if (definedClass.block)
			if (definedClass.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.definedClass_BlockEnd,
					NO_CLASS_END_NAME,
					definedClass.name)
	}
	
	public static val NO_OBJECT_END_NAME = FormlValidator.ISSUE_PREFIX + "NoObjectEndName"
	@Check
	def checkObjectEndNameExists(Object object) {
		if (object.block)
			if (object.endName === null)
				warning(
					"No end name", 
					FormlPackage.eINSTANCE.object_BlockEnd,
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
		if (model.block) {
			val name = model.name
			val endName = model.endName
			if (model.endName != name)
				error(
					"End name " + endName + " different from name " + name, 
					FormlPackage.eINSTANCE.model_EndName,
					INCORRECT_MODEL_END_NAME,
					name,
					endName)
		}			
	}

	public static val INCORRECT_PARTIAL_MODEL_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectPartialModelEndName"
	@Check
	def checkPartialModelEndName(PartialModel partialModel) {
		if (partialModel.block)
			if (partialModel.endName != partialModel.name)
				error(
					"End name " + partialModel.endName + " different from name " + partialModel.name, 
					FormlPackage.eINSTANCE.partialModel_EndName,
					INCORRECT_PARTIAL_MODEL_END_NAME,
					partialModel.name,
					partialModel.endName)
	}

	public static val INCORRECT_CLASS_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectClassEndName"
	@Check
	def checkClassEndName(DefinedClass definedClass) {
		if (definedClass.block)
			if (definedClass.endName != definedClass.name)
				error(
					"End name " + definedClass.endName + " different from name " + definedClass.name, 
					FormlPackage.eINSTANCE.definedClass_EndName,
					INCORRECT_CLASS_END_NAME,
					definedClass.name,
					definedClass.endName)
	}

	public static val INCORRECT_OBJECT_END_NAME = FormlValidator.ISSUE_PREFIX + "IncorrectObjectEndName"
	@Check
	def checkOjectEndName(Object object) {
		if (object.block)
			if (object.endName != object.name)
				error(
					"End name " + object.endName + " different from name " + object.name, 
					FormlPackage.eINSTANCE.object_EndName,
					INCORRECT_OBJECT_END_NAME,
					object.name,
					object.endName)
	}
}