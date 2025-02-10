package forml.tests

import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.resource.impl.ResourceDescriptionsProvider
import org.eclipse.emf.ecore.EObject
import forml.forml.FormlPackage

import forml.forml.Models
import org.eclipse.xtext.scoping.IScopeProvider
import forml.forml.DefinedClass
import forml.forml.PartialModel
import forml.forml.Object

@ExtendWith(InjectionExtension)

@InjectWith(FormlInjectorProvider)

class FormlScopingLearningTest {
	@Inject
	ParseHelper<Models> parseHelper
	@Inject ResourceDescriptionsProvider rdp
	@Inject extension IScopeProvider
	
	def getResourceDescription(EObject o) {
		val index = rdp.getResourceDescriptions(o.eResource)
		index.getResourceDescription(o.eResource.URI)
	}
	
	def getExportedEObjectDescriptions(EObject o) {
		o.getResourceDescription.getExportedObjects
	}
	
	def getExportedClassesEObjectDescriptions(EObject o) {
		o.getResourceDescription.
		getExportedObjectsByType(FormlPackage.eINSTANCE.definedClass)
	}
	
	@Test
	def void FormlScoping_01 () {
		val result = parseHelper.parse('''
			Model TestModel begin
				partial Model Partial begin 
					Boolean b;
					Integer i;
					Class C begin
						Real r;
					end C;
				end Partial;	
			end TestModel;
		''')
		for (s : result.getExportedEObjectDescriptions.map[qualifiedName]) {
			System.out.println(s)
		}
		System.out.println("")
		for (s : result.getExportedClassesEObjectDescriptions.map[qualifiedName]) {
			System.out.println(s)
		}
	}
	
	@Test
	def void FormlScoping_02 () {
		val result = parseHelper.parse('''
			Model TestModel begin
				partial Model Partial1 begin 
					Boolean b;
					Class E;
					Class F;
					partial Model Partial2 begin
						Class G;
						Class E;
						end Partial2;
					D, E, F instance;
					end Partial1;	
				Integer i;
				Class C begin
					Real r;
					end C;
				Class D;
				Class E;
				C, D instance;
			end TestModel;
		''')
		val model = result.models.head
		System.out.println("Model name = " + model.name)
		System.out.println(model.statements.length + " statements")
		for (var i=0 ; i < model.statements.length ; i++) {
			var s = model.statements.get(i)
			if (s.partialModel !== null) 
				System.out.println("Partial Model name = " + s.partialModel.name)
			if (s.object !== null) 
				System.out.println("Object name = " + s.object.name)
			if (s.definedClass !== null) 
				System.out.println("Class name = " + s.definedClass.name)
			}
		val reference = FormlPackage.eINSTANCE.objectClass_DefinedClass
		val instance = model.statements.get(5)
		val scope = instance.getScope(reference)
		System.out.println("Reference = " + reference)
		for (s : scope.allElements.map[name]) 
			System.out.println("Scope " + s)
	}
}