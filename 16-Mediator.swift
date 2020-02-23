// Our system has any number of instances of `Participant` classes. Each participant has a `value` integer, initially zero.
// A participant can `say()` a particular value, which is broadcast to all other participants.
// At this point in time, every other participant is OBLIGED to increase their `value` by the value being broadcasted.

import Foundation

class Participant {
  private let mediator: Mediator
  var value = 0

  init(_ mediator: Mediator) {
    self.mediator = mediator
    mediator.participants.append(self)
  }

  func say(_ n: Int) {
    mediator.broadcast(self, n)
  }
}

class Mediator {
  var participants = [Participant]()

  init() {}

  func broadcast(_ sender: Participant, _ value: Int) {
    for participant in participants where participant !== sender {
      participant.value += value
    }
  }
}
