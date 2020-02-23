// You are asked to implement the Builder design pattern for rendering simple chunks of code.
// A sample use of the builder you are asked to create is:
// var cb = CodeBuilder("Person").AddField("name", "String").addField("age", "Int")
// print(cb.description)
//
// The expected output is:
//
// class Person
// {
//    var name: String
//    var age: Int
// }
//
// Please observe the same placement of curly braces and use two-space indentation.

import Foundation

class FieldElement {
  var name: String = ""
  var type: String = ""
  
  init() {}
  
  init(name: String, type: String) {
    self.name = name
    self.type = type
  }
  
  func description(_ indent: Int) -> String {
    var result = ""
    let i = String(repeating:" ", count: indent)
    
    result += i + "var " + self.name + ": " + self.type + "\n"
    return result
  }
}

class CodeBuilder : CustomStringConvertible {
  private let rootName: String
  private var fields: [FieldElement] = []
  
  init(_ rootName: String) {
    self.rootName = rootName
  }

  func addField(called name: String, ofType type: String) -> CodeBuilder {
    let field = FieldElement(name: name, type: type)
    fields.append(field)
    
    return self
  }

  public var description: String {
    var result = "class " + rootName + "\n{\n"
    
    for f in fields {
      result += f.description(2)
    }
    
    return result + "}\n"
  }
}