// A magic square is a square matrix of numbers where the sum in each row, each column
// and each of the diagonals is the same. You are given a system of 3 classes that can
// be used to make a magic square. The classes are:
//
// - Generator: this class generates a 1-dimensional array of random digits in range 1 to 9
// - Splitter: this class takes a 2D array and splits it into all possible arrangements of
//   1D arrays. It gives you the columns, the rows and the two diagonals.
// - Verifier: this class takes a 2D array and verifies that the sum of elements in every subarray is the same.
//
// Please implement a Façade class called 'MagicSquareGenerator' which simply generates the
// magic square of a given size.

import Foundation

class Generator {
    func generate(_ count: Int) -> [Int] {
        var result = [Int]()
        
        for _ in 1...count {
            result.append(1 + Int.random(in: 1..<10))
        }

        return result
    }
}

class Splitter {
    func split(_ array: [[Int]]) -> [[Int]] {
        var result = [[Int]]()
        let rowCount = array.count
        let colCount = array[0].count

        // get the rows
        for r in 0..<rowCount {
            var theRow = [Int]()

            for c in 0..<colCount {
                theRow.append(array[r][c])
            }

            result.append(theRow)
        }

        // get the columns
        for c in 0..<colCount {
            var theCol = [Int]()
            
            for r in 0..<rowCount {
                theCol.append(array[r][c])
            }

            result.append(theCol)
        }

        // get the diagonals
        var diag1 = [Int]()
        var diag2 = [Int]()
        
        for c in 0..<colCount {
            for r in 0..<rowCount {
                if c == r {
                    diag1.append(array[r][c])
                }

                let r2 = rowCount - r - 1

                if c == r2 {
                    diag2.append(array[r][c])
                }
            }
        }

        result.append(diag1)
        result.append(diag2)

        return result
    }
}

class Verifier {
    func verify(_ arrays: [[Int]]) -> Bool {
        let first = arrays[0].reduce(0, +)
        
        for arr in 1..<arrays.count {
            if (arrays[arr].reduce(0, +)) != first {
                return false
            }
        }

        return true
    }
}

// Solution
class MagicSquareGenerator {
    func generate(_ size: Int) -> [[Int]] {
        let generator = Generator()
        let splitter = Splitter()
        let verifier = Verifier()

        var isMagicSquare = false
        var width: [Int]
        var height: [Int]

        repeat {
            width = generator.generate(size)
            height = generator.generate(size)

            let arrangements = splitter.split([width, height])

            isMagicSquare = verifier.verify(arrangements)
        } while !isMagicSquare

        return [width, height]
    }
}
