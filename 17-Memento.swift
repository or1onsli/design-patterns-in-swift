// You are given a class called TokenMachine which keeps tokens. Each token is a class with a single value.
// The TokenMachine actually has two members: one takes an integer and another takes an already-made token.
// Both overloads need to add its tokens to the set of tokens and return a Memento that allows us to subsequently call 'revert(to:)' to roll the system back to the original state.
// Please implement the missing members.

import Foundation

class Token {
  var value = 0

  init(_ value: Int) {
    self.value = value
  }

  init(copyFrom other: Token) {
    self.value = other.value
  }

  static func ==(_ lhs: Token, _ rhs: Token) -> Bool {
    return lhs.value == rhs.value
  }
}

class Memento {
  var tokens = [Token]()

  init(withTokens tokens: [Token]) {
    self.tokens = tokens.map { Token(copyFrom: $0) }
  }
}

class TokenMachine {
  var tokens = [Token]()

  func addToken(_ value: Int) -> Memento {
    tokens.append(Token(value))
    return Memento(withTokens: tokens)
  }

  func addToken(_ token: Token) -> Memento {
    tokens.append(token)
    return Memento(withTokens: tokens)
  }

  func revert(to m: Memento) {
    tokens = m.tokens.map{ Token(copyFrom: $0) }
  }
}