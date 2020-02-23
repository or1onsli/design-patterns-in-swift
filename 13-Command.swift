// Implement the 'Account.process(_ command: Command)' function to process
// withdraw and deposit actions. Remember, 'success' must be true only when a successful
// command has been processed.

import Foundation

enum Action {
    case deposit
    case withdraw
}

class Command {
  var action: Action
  var amount: Int
  var success = false

  init(_ action: Action, _ amount: Int) {
    self.action = action
    self.amount = amount
  }
}

class Account {
  var balance = 0

  func process(_ command: Command) {
    switch command.action {
      case .deposit:
        balance += command.amount
        command.success = true
      case .withdraw:
        let newBalance = balance - command.amount

        if newBalance >= 0 {
          balance = newBalance
          command.success = true
        } else {
          command.success = false
        }
    }
  }
}
