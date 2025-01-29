/*
 * generated by Xtext 2.37.0
 */
package forml.ui.quickfix

// 29 January 2025

import org.eclipse.xtext.ui.editor.quickfix.DefaultQuickfixProvider
import org.eclipse.xtext.ui.editor.quickfix.Fix
import org.eclipse.xtext.ui.editor.quickfix.IssueResolutionAcceptor
import org.eclipse.xtext.validation.Issue
import forml.validation.FormlNameValidator
import forml.validation.FormlEndNameValidator
import forml.forml.Model
import forml.forml.PartialModel
import forml.forml.DefinedClass
import forml.forml.Object

/**
 * Custom quickfixes.
 *
 * See https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#quick-fixes
 */
class FormlQuickfixProvider extends DefaultQuickfixProvider {
/**
 * Name 
 *
 */
	@Fix(FormlNameValidator.UNCAPITALIZED_MODEL_NAME)
	def capitalizeModelName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Textual modification
	{	acceptor.accept(
			issue, 
			"Capitalize name", 			// label
			"Change '" + issue.data.get(0) + "' to '" + issue.data.get(0).toFirstUpper + "'", 
			"upcase.png"				// icon
		) [	context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toUpperCase)
		  ]
	}

	@Fix(FormlNameValidator.UNCAPITALIZED_PARTIAL_MODEL_NAME)
	def capitalizePartialModelName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Textual modification
	{	acceptor.accept(
			issue, 
			"Capitalize name", 			// label
			"Change '" + issue.data.get(0) + "' to '" + issue.data.get(0).toFirstUpper + "'", 
			"upcase.png"				// icon
		) [	context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toUpperCase)
		  ]
	}
	
@Fix(FormlNameValidator.UNCAPITALIZED_CLASS_NAME)
	def capitalizeClassName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Textual modification
	{	acceptor.accept(
			issue, 
			"Capitalize name", 			// label
			"Change '" + issue.data.get(0) + "' to '" + issue.data.get(0).toFirstUpper + "'", 
			"upcase.png"				// icon
		) [	context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toUpperCase)
		  ]
	}

	@Fix(FormlNameValidator.INCORRECT_OBJECT_NAME)
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
 * No end name
 *
 */
	@Fix(FormlEndNameValidator.NO_MODEL_END_NAME)
	def addModelEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Add end name", 			// label
			"Proposed end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as Model).endName = issue.data.get(0)
			]
		)
	}
	
	@Fix(FormlEndNameValidator.NO_PARTIAL_MODEL_END_NAME)
	def addPartialModelEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Add end name", 			// label
			"Proposed end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as PartialModel).endName = issue.data.get(0)
			]
		)
	}
	
	@Fix(FormlEndNameValidator.NO_CLASS_END_NAME)
	def addClassEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Add end name", 			// label
			"Proposed end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as DefinedClass).endName = issue.data.get(0)
			]
		)
	}

	@Fix(FormlEndNameValidator.NO_OBJECT_END_NAME)
	def addObjectEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Add end name", 			// label
			"Proposed end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as Object).endName = issue.data.get(0)
			]
		)
	}

/**
 * End name different from name
 *
 */
	@Fix(FormlEndNameValidator.INCORRECT_MODEL_END_NAME)
	def changeModelEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change end name '" + issue.data.get(1) + "' to '" + issue.data.get(0) + "'", 	// label
			"Proposed new end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as Model).endName = issue.data.get(0)
			]
		)
	}

	@Fix(FormlEndNameValidator.INCORRECT_MODEL_END_NAME)
	def changeModelName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change name '" + issue.data.get(0) + "' to '" + issue.data.get(1) + "'", // label
			"Proposed name '" + issue.data.get(1) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as Model).name = issue.data.get(1)
			]
		)
	}

	@Fix(FormlEndNameValidator.INCORRECT_PARTIAL_MODEL_END_NAME)
	def changePartialModelEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change end name '" + issue.data.get(1) + "' to '" + issue.data.get(0) + "'", 	// label
			"Proposed new end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as PartialModel).endName = issue.data.get(0)
			]
		)
	}

	@Fix(FormlEndNameValidator.INCORRECT_PARTIAL_MODEL_END_NAME)
	def changePartialModelName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change name '" + issue.data.get(0) + "' to '" + issue.data.get(1) + "'", // label
			"Proposed new name '" + issue.data.get(1) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as PartialModel).name = issue.data.get(1)
			]
		)
	}

	@Fix(FormlEndNameValidator.INCORRECT_CLASS_END_NAME)
	def changeClassEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change end name '" + issue.data.get(1) + "' to '" + issue.data.get(0) + "'", 	// label
			"Proposed new end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as DefinedClass).endName = issue.data.get(0)
			]
		)
	}

	@Fix(FormlEndNameValidator.INCORRECT_CLASS_END_NAME)
	def changeClassName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change name '" + issue.data.get(0) + "' to '" + issue.data.get(1) + "'", // label
			"Proposed new name '" + issue.data.get(1) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as DefinedClass).name = issue.data.get(1)
			]
		)
	}

	@Fix(FormlEndNameValidator.INCORRECT_OBJECT_END_NAME)
	def changeObjectEndName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change end name '" + issue.data.get(1) + "' to '" + issue.data.get(0) + "'", 	// label
			"Proposed new end name '" + issue.data.get(0) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as Object).endName = issue.data.get(0)
			]
		)
	}

	@Fix(FormlEndNameValidator.INCORRECT_OBJECT_END_NAME)
	def changeObjectName(Issue issue, IssueResolutionAcceptor acceptor) 
	// Model modification
	{	acceptor.accept(
			issue, 
			"Change name '" + issue.data.get(0) + "' to '" + issue.data.get(1) + "'", // label
			"Proposed new name '" + issue.data.get(1) + "'", 
			"",							// no icon for now
			[ element, context |
				(element as Object).name = issue.data.get(1)
			]
		)
	}
}
