// Given the provided code, you are asked to implement 'Line.deepCopy()'
// to perform a deep copy of the current 'Line' object.

import Foundation

protocol Copying {
    func deepCopy() -> Self
}

class Point : Copying {
    var x = 0
    var y = 0

    init() {}

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    func deepCopy() -> Self {
        return cloningFunc()
    }

    private func cloningFunc<T>() -> T {
        return Point(x: x, y: y) as! T
    }
}

class Line: Copying {
    var start = Point()
    var end = Point()

    init(start: Point, end: Point) {
        self.start = start
        self.end = end
    }

    func deepCopy() -> Self {
        return cloningFunc()
    }

    private func cloningFunc<T>() -> T {
        return Line(start:start.deepCopy(), end: end.deepCopy()) as! T
    }
}


// Given the fact that 'x' and 'y' in the class 'Point' are of type Int (aka struct) this could have been simply implemented
// in this way:
//
// func deepCopy() -> Line {
//   let newStart = Point(x: start.x, y: start.y)
//   let newEnd = Point(x: end.x, y: end.y)
//   
//   return Line(start: newStart, end: newEnd)
// }
