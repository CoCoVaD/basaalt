/*
 * generated by Xtext 2.37.0
 */
package forml.ui.quickfix

import org.eclipse.xtext.ui.editor.quickfix.DefaultQuickfixProvider
import org.eclipse.xtext.ui.editor.quickfix.Fix
import org.eclipse.xtext.ui.editor.quickfix.IssueResolutionAcceptor
import org.eclipse.xtext.validation.Issue
import forml.validation.FormlValidator
import forml.forml.Model

/**
 * Custom quickfixes.
 *
 * See https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#quick-fixes
 */
class FormlQuickfixProvider extends DefaultQuickfixProvider {
/**
 * Names 
 *
 */
	@Fix(FormlValidator.INCORRECT_MODEL_NAME)
	def capitalizeModelName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Textual modification
	{	acceptor.accept(
			issue, 
			"Capitalize name", 			// label
			"Change '" + issue.data.get(0) + "' to '" + issue.data.get(0).toFirstUpper + "'", 
			"upcase.png"				// icon
		) [
			context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toUpperCase)
		  ]
	}

	@Fix(FormlValidator.INCORRECT_PARTIAL_MODEL_NAME)
	def capitalizePartialModelName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Textual modification
	{	acceptor.accept(
			issue, 
			"Capitalize name", 			// label
			"Change '" + issue.data.get(0) + "' to '" + issue.data.get(0).toFirstUpper + "'", 
			"upcase.png"				// icon
		) [
			context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toUpperCase)
		  ]
	}
	
@Fix(FormlValidator.INCORRECT_CLASS_NAME)
	def capitalizeClassName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Textual modification
	{	acceptor.accept(
			issue, 
			"Capitalize name", 			// label
			"Change '" + issue.data.get(0) + "' to '" + issue.data.get(0).toFirstUpper + "'", 
			"upcase.png"				// icon
		) [
			context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toUpperCase)
		  ]
	}

	@Fix(FormlValidator.INCORRECT_OBJECT_NAME)
	def unCapitalizeObjectName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Textual modification
	{	acceptor.accept(
			issue, 
			"Un-capitalize name", 			// label
			"Change '" + issue.data.get(0) + "' to '" + issue.data.get(0).toFirstLower + "'", 
			"downcase.png"				// icon
		) [	context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toLowerCase)
		  ]
	}
	
/**
 * End names 
 *
 */
	@Fix(FormlValidator.NO_MODEL_END_NAME)
	def addModelEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Add end name", 			// label
			"Proposed end name: '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as Model).endName = issue.data.get(0)
			]
		)
	}

	@Fix(FormlValidator.INCORRECT_MODEL_END_NAME)
	def changeModelEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change end name '" + issue.data.get(1) + "'", 			// label
			"Proposed end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as Model).endName = issue.data.get(0)
			]
		)
	}
}
