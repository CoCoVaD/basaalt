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
import forml.forml.Section
import forml.forml.Object
import forml.forml.SimpleClass
import forml.forml.Enumeration
import org.eclipse.xtext.naming.QualifiedName
import forml.forml.Model

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
		getExportedObjectsByType(FormlPackage.eINSTANCE.simpleClass)
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
		System.out.println("")
		System.out.println("=============================================")
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
			if (s.section !== null) 
				System.out.println("Partial Model name = " + s.section.name)
			if (s.simpleClass !== null) 
				System.out.println("Class name = " + s.simpleClass.name)
			if (s.object !== null) 
				System.out.println("Object name = " + s.object.name)
		}
		val reference = FormlPackage.eINSTANCE.object_Classes
		System.out.println("Reference = " + reference)
		val instance = model.statements.get(5)
		val scope = instance.getScope(reference)
		for (s : scope.allElements.map[name]) 
			System.out.println("Scope " + s)
	}
	
	@Test
	def void FormlScoping_03 () {
		System.out.println("")
		System.out.println("=============================================")
		System.out.println("FormlScoping_03")
		val result = parseHelper.parse('''
			Model TestModel begin
				Class A;
				Class B begin
					Boolean b1;
				end B;
			end TestModel;
			Class C;
			A begin
				Integer i;
			end A;
			Class D;
			partial Model P begin
				Class E;
			end P;
		''')
		System.out.println("Index of all qualified names")
		for (s : result.getExportedEObjectDescriptions.map[qualifiedName]) {
			System.out.println(s)
		}
		System.out.println("")
		val model = result.models.head
		System.out.println("Model name = " + model.name)
		System.out.println(model.statements.length + " statements in TestModel")
		for (var i=0 ; i < model.statements.length ; i++) {
			var s = model.statements.get(i)
			if (s.section !== null) 
				System.out.println("  - Statement " + (i+1) + ": Partial Model name = " + s.section.name)
			if (s.simpleClass !== null) 
				System.out.println("  - Statement " + (i+1) + ": Class name = " + s.simpleClass.name)
			if (s.object !== null) 
				System.out.println("  - Statement " + (i+1) + ": Object name = " + s.object.name)
			if (s.definition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Definition is " + s.definition)
			if (s.objectGlobalDefinition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Object global definition is " + s.objectGlobalDefinition)
		}
		val reference = FormlPackage.eINSTANCE.definition_Item
		val definition = model.statements.get(3).definition 
		val item = definition.item
		System.out.println(" ")
		switch item {
			Section: System.out.println("Name of referenced partial model in definition (statement 4): " + item.name)
			SimpleClass:  System.out.println("Name of referenced class in definition (statement 4): " + item.name)
			Enumeration:  System.out.println("Name of referenced enumeration in definition (statement 4): " + item.name)
			Object:       System.out.println("Name of referenced object in definition (statement 4): " + item.name)
		}
		val scope = definition.getScope(reference).allElements
		System.out.println(" ")
		System.out.println(scope.length + " elements in scope of definition block for statement 4")
		var i = 1
		for (s : scope.map[name]) 
			System.out.println("  - Scope element " + (i++) + " : " + s)
	}
	
	@Test
	def void FormlScoping_04 () {
		System.out.println("")
		System.out.println("=============================================")
		System.out.println("FormlScoping_04")
		val result = parseHelper.parse('''
			Model TestModel begin
				Class A;
				Class B begin
					Boolean b1;
				end B;
				Class A begin
					Boolean b;
				end A;
				A, Integer ai;
				Integer, A ai;
				ai begin end ai;
			end TestModel;
		''')
		System.out.println("Index of all qualified names")
		for (s : result.getExportedEObjectDescriptions.map[qualifiedName]) {
			System.out.println(s)
		}
		System.out.println("")
		val model = result.models.head
		System.out.println("Model name = " + model.name)
		System.out.println(model.statements.length + " statements in TestModel")
		for (var i=0 ; i < model.statements.length ; i++) {
			var s = model.statements.get(i)
			if (s.section !== null) 
				System.out.println("  - Statement " + (i+1) + ": Partial Model name = " + s.section.name)
			if (s.simpleClass !== null) 
				System.out.println("  - Statement " + (i+1) + ": Class name = " + s.simpleClass.name)
			if (s.object !== null) 
				System.out.println("  - Statement " + (i+1) + ": Object name = " + s.object.name)
			if (s.definition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Definition is " + s.definition)
			if (s.objectGlobalDefinition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Object global definition is " + s.objectGlobalDefinition)
		}
		val exportedObjects = getExportedEObjectDescriptions(result)
			for (objectDescription: exportedObjects) {
				var object=objectDescription.EObjectOrProxy
				switch object {
					Section: System.out.println("Exported EObject: name=" + objectDescription.name + ", class=PartialModel")
					SimpleClass:  System.out.println("Exported EObject: name=" + objectDescription.name + ", class=SimpleClass")
					Enumeration:  System.out.println("Exported EObject: name=" + objectDescription.name + ", class=Enumeration")
					Object:       System.out.println("Exported EObject: name=" + objectDescription.name + ", class=O")
				}
			}
	}
	
	@Test
	def void FormlScoping_05 () {
		System.out.println("")
		System.out.println("=============================================")
		System.out.println("FormlScoping_05")
		val result = parseHelper.parse('''
			Model TestModel begin
				Class A;
				Class B begin
					Boolean b1;
				end B;
				Class A begin
					Boolean b;
				end A;
				A, Integer ai;
				Integer, A ai;
				ai begin end ai;
			end TestModel;
		''')
		val descriptions = result.getExportedEObjectDescriptions
		System.out.println("Index of all qualified names, starting from the top")
		for (s : descriptions.map[qualifiedName]) System.out.println(s)
		System.out.println("")
		
		val model = result.models.head
		System.out.println("Model name = " + model.name)
		System.out.println(model.statements.length + " statements in TestModel")
		
		for (var i=0 ; i < model.statements.length ; i++) {
			var s = model.statements.get(i)
			if (s.section !== null) 
				System.out.println("  - Statement " + (i+1) + ": Partial Model name = " + s.section.name)
			if (s.simpleClass !== null) 
				System.out.println("  - Statement " + (i+1) + ": Class name = " + s.simpleClass.name)
			if (s.object !== null) 
				System.out.println("  - Statement " + (i+1) + ": Object name = " + s.object.name)
			if (s.definition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Definition is " + s.definition)
			if (s.objectGlobalDefinition !== null) 
				System.out.println("  - Statement " + (i+1) + ": Object global definition is " + s.objectGlobalDefinition)
		}
		System.out.println("")
		
		val statement3 = model.statements.get(2)
		System.out.println("Statement 3: " + statement3)
		System.out.println("")
		
		val descriptions2 = statement3.getExportedEObjectDescriptions
		System.out.println("Index of all qualified names, starting from statement 3")
		for (s : descriptions2.map[qualifiedName]) System.out.println(s)
		System.out.println("")
		
		val exportedObjects = getExportedEObjectDescriptions(result)
			for (objectDescription: exportedObjects) {
				var object=objectDescription.EObjectOrProxy
				switch object {
					Section: System.out.println("Exported EObject: name=" + objectDescription.name + ", class=PartialModel")
					SimpleClass:  System.out.println("Exported EObject: name=" + objectDescription.name + ", class=SimpleClass")
					Enumeration:  System.out.println("Exported EObject: name=" + objectDescription.name + ", class=Enumeration")
					Object:       System.out.println("Exported EObject: name=" + objectDescription.name + ", class=O")
				}
			}
	}
	
	@Test
	def void FormlScoping_06 () {
		System.out.println("")
		System.out.println("=============================================")
		System.out.println("FormlScoping_06")
		val  qName1 = QualifiedName.EMPTY
		System.out.println("Step 1: '" + qName1 +"'")
		
		val  qName2 = qName1.append("localName")
		System.out.println("Step 2: '" + qName2 +"'")
		
		val  qName3 = qName1.append("parentName").append(qName2)
		System.out.println("Step 3: '" + qName3 +"'")
		
		val  qName4 = qName1.append("grandParentName").append(qName3)
		System.out.println("Step 4: '" + qName4 +"'")
	}
	
	def getQualifiedName(EObject o) {
		var qName = QualifiedName.EMPTY
		var current = o
		
		while (current !== null) {
			switch current {
				Model,
				Section,
				SimpleClass,
				Enumeration,
				Object:       qName = QualifiedName.create(current.name).append(qName)
			}
			current = current.eContainer
		}
		qName
	}
	
	@Test
	def void FormlScoping_07 () {
		System.out.println("")
		System.out.println("=============================================")
		System.out.println("FormlScoping_07")
		val result = parseHelper.parse('''
			Model TestModel begin
				Class A;
				Class B begin
					Boolean b1;
				end B;
				Class A begin
					Boolean b;
				end A;
				A, Integer ai;
				Integer, A ai;
				ai begin end ai;
			end TestModel;
		''')
		val descriptions = result.getExportedEObjectDescriptions
		for (d : descriptions) 
			System.out.println("qName '" + d.EObjectOrProxy.getQualifiedName +"'")
	}
	
	
}