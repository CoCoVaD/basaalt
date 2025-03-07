/*
 * generated by Xtext 2.37.0
 */
package forml.validation

// 29 January 2025

import org.eclipse.xtext.validation.ComposedChecks

import forml.validation.FormlNameValidator
import forml.validation.FormlEndNameValidator
import forml.validation.FormlExtensionValidator
import forml.validation.FormlEnumerationValidator
import forml.validation.FormlMultipleDeclarationsValidator

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */

@ComposedChecks(validators = #[
	FormlNameValidator, 
	FormlEndNameValidator, 
	FormlExtensionValidator, 
	FormlMultipleDeclarationsValidator,
	FormlEnumerationValidator
])

class FormlValidator extends AbstractFormlValidator {
	
	protected static val ISSUE_PREFIX = 'forml.'
}
