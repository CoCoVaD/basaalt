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
		System.out.println("FormlScoping_01")
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
		System.out.println("FormlScoping_02")
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
			Class X;
			Class Y;
		''')
		val model = result.models.head
		System.out.println("Model name = " + model.name)
		System.out.println(model.statements.length + " statements")
		for (var i=0 ; i < model.statements.length ; i++) {
			var s = model.statements.get(i)
			if (s.partialModel !== null) 
				System.out.println("Partial Model name = " + s.partialModel.name)
			if (s.definedClass !== null) 
				System.out.println("Class name = " + s.definedClass.name)
			if (s.object !== null) 
				System.out.println("Object name = " + s.object.name)
		}
		val reference = FormlPackage.eINSTANCE.classOfObject_DefinedClass
		System.out.println("Reference = " + reference)
		val instance = model.statements.get(5)
		val scope = instance.getScope(reference)
		for (s : scope.allElements.map[name]) 
			System.out.println("Scope " + s)
	}
	
	@Test
	def void FormlScoping_03 () {
		System.out.println("FormlScoping_03")
		val result = parseHelper.parse('''
			Model TestModel begin
				Class A;
				Class B;
			end TestModel;
			Class C;
			refined class P.E begin
				Integer i;
			end A;
			Class D;
			partial Model P begin
				Class E;
			end P;
		''')
		val model = result.models.head
		System.out.println("Model name = " + model.name)
		System.out.println(model.statements.length + " statements")
		for (var i=0 ; i < model.statements.length ; i++) {
			var s = model.statements.get(i)
			if (s.partialModel !== null) 
				System.out.println("  - Statement " + (i+1) + ": Partial Model name = " + s.partialModel.name)
			if (s.definedClass !== null) 
				System.out.println("  - Statement " + (i+1) + ": Class name = " + s.definedClass.name)
			if (s.object !== null) 
				System.out.println("  - Statement " + (i+1) + ": Object name = " + s.object.name)
			if (s.partialModelDefinition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Partial model definition is " + s.partialModelDefinition)
			if (s.classDefinition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Class definition is " + s.classDefinition)
			if (s.objectDefinition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Class definition is " + s.classDefinition)
		}
		val reference = FormlPackage.eINSTANCE.classDefinition_Item
		val definition = model.statements.get(3).classDefinition 
		val scope = definition.getScope(reference).allElements
		System.out.println(" ")
		System.out.println(scope.length + " elements in scope of definition block for statement 4")
		var i = 1
		for (s : scope.map[name]) 
			System.out.println("  - Scope element " + (i++) + " : " + s)
	}
}