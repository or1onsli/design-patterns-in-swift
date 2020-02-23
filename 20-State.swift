// A combination lock is a lock that opens after the right digits have been entered. A lock
// is preprogrammed with a combination (e.g. '12345') and the user is expected to enter this
// combination to unlock the lock.
//
// The lock has a 'status' property that indicates the state of the lock. The rules are:
// - If the lock has just been locked (or at startup), the status is LOCKED.
// - If a digit has been entered, that digit is shown on the screen. As the user enters
//   more digits, they are added to 'status'.
// - If the user has entered the correct sequence of digits, the lock status changes to OPEN.
// - If the user enters an incorrect sequence of digits, the lock status changes to ERROR.
//
// Please implement the 'CombinationLock' class to enable this behaviour. Be sure to test
// both correct and incorrect inputs.

import Foundation

class CombinationLock {
    private let combination: [Int]
    var status = ""

    private var digitsEntered = 0
    private var failed = false

    init(_ combination: [Int]) {
        self.combination = combination
        reset()
    }

    private func reset() {
        self.status = "LOCKED"
        self.digitsEntered = 0
        self.failed = false
    }

    func enterDigit(_ digit: Int) {
        if (status == "LOCKED") { status = "" }
        status += String(digit)

        if self.combination[self.digitsEntered] != digit {
            failed = true
        }

        self.digitsEntered += 1

        if self.digitsEntered == self.combination.count {
            self.status = self.failed ? "ERROR" : "OPEN"
        }
    }
}

// Test Demo
//
// let number0 = 3.56
// let number1 = 0.123
// let number2 = 0.0
// let number3 = 4.23
// let number4 = 13.77
// let number5 = 24.1
//
// func testSwitch(_ number: Double) {
//     let number = Int(number)
//
//     switch number {
//     case 0:
//         print("Zero value")
//     case 3:
//         print("\(number * 3)")
//     case 4:
//         print("\(number * 4)")
//     case 13:
//         print("\(number * 13)")
//     default:
//         print("Unrecognized value!")
//     }
// }
//
// testSwitch(number0)
// testSwitch(number1)
// testSwitch(number2)
// testSwitch(number3)
// testSwitch(number4)
// testSwitch(number5)