package forml.validation

import org.eclipse.xtext.validation.Check

import forml.forml.FormlPackage
import forml.validation.FormlValidator
import forml.forml.States

class FormlEnumerationValidator extends AbstractFormlValidator {
	public static val IDENTICAL_STATE_NAMES = FormlValidator.ISSUE_PREFIX + "IdenticalStateNames"
	@Check
	def checkStateNamesAreNotDuplicated (States states) {
		val names = states.states.map[name].sort
		for (var i=0 ; i<names.length-1 ; i++)
			if (names.get(i).equals(names.get(i+1)))
				error(
					"Identical state names " + names.get(i), 
					FormlPackage.eINSTANCE.states_States,
					IDENTICAL_STATE_NAMES,
					names.get(i))
	}
 	
	public static val ATOMIC_STATE_IN_CARTESIAN_PRODUCT = FormlValidator.ISSUE_PREFIX + "AtomicStateInCartesianProduct"
	@Check
	def checkNoAtomicStatesInCartesianProduct (States states) {
		if (states.product) 
			for (state : states.states)
				if (state.states === null && state.enumeration === null)
					error(
						"Atomic state " + state.name + " in Cartesian product", 
						FormlPackage.eINSTANCE.states_States,
						ATOMIC_STATE_IN_CARTESIAN_PRODUCT,
						state.name)
	}
}