// You are given an example of inheritance hierarchy which results in Cartesian-product
// duplication. Please refactor this hierarchy, giving the base class 'Shape' an initializer
// that takes a 'Renderer' and define a 'Vector Renderer' and a 'Raster Renderer'.
// The expectation is that each object's 'description' operates correctly:
//
// i.e. Triangle(RasterRenderer()).description ----> "Drawing Triangle as pixels"

import Foundation

protocol Renderer {
  var whatToRenderAs: String { get }
}

class VectorRenderer: Renderer {
  var whatToRenderAs: String {
    return "lines"
  }
}

class RasterRenderer: Renderer {
  var whatToRenderAs: String {
    return "pixels"
  }
}

class Shape: CustomStringConvertible {
  var name: String
  var renderer: Renderer

  init(_ renderer: Renderer) {
    self.name = ""
    self.renderer = renderer
  }

  var description: String {
    return "Drawing \(name) as \(renderer.whatToRenderAs)"
  }
}

class Triangle: Shape {
  override init(_ renderer: Renderer) {
    super.init(renderer)
    name = "Triangle"
  }
}

class Square: Shape {
  override init(_ renderer: Renderer) {
    super.init(renderer)
    name = "Square"
  }
}

// Imagine e.g. VectorTriangle/RasterTriangle etc. here