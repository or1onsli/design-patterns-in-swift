// You are given a 'Rectangle' protocol and an extension method on it. Try to define a
// 'SquareToRectangleAdapter' that adapts the 'Square' to the 'Rectangle' protocol.

import Foundation

class Square {
    private(set) var side = 0

    init(side: Int) {
        self.side = side
    }
}

protocol Rectangle {
    var width: Int { get }
    var height: Int { get }
}

extension Rectangle {
    var area: Int {
        return self.width * self.height
    }
}

class SquareToRectangleAdapter : Rectangle {
    private let square: Square

    var width: Int { return square.side }
    var height: Int { return square.side }
    
    init(_ square: Square) {
        self.square = square
    }
}
