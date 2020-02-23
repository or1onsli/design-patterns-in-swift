// Consider the code presented below. The 'sum()' extension method adds up all the values
// in a list of 'Sequence' - conforming elements it gets passed. We can have a single value
// or a set of values, all of them get added up toghether.
//
// Please complete the implementation of the extension so that 'sum()' begins to work correctly.

import Foundation

class SingleValue : Sequence {
    var value = 0

    init() {}
    
    init(_ value: Int) {
        self.value = value
    }

    func makeIterator() -> IndexingIterator<Array<Int>> {
        return IndexingIterator(_elements: [value])
    }
}

class ManyValues : Sequence {
    var values = [Int]()

    func makeIterator() -> IndexingIterator<Array<Int>> {
        return IndexingIterator(_elements: values)
    }

    func add(_ value: Int) {
        values.append(value)
    }
}

// Solution
extension Sequence where Iterator.Element: Sequence, Iterator.Element.Iterator.Element == Int {
    func sum() -> Int {
        var result: Int = 0

        for element in self {
            for value in element {
                result += value
            }
        }

        return result
    }
}