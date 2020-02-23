// Imagine a typical collectible card game which has cards representing creatures.
// Each creature has two properties: 'attack' and 'health'.
// Creatures can fight each other, dealing their 'attack' damage, thereby reducing their
// opponent's 'health'.
//
// The class CardGame implements the logic for two creatures fighting one another.
// However, the exact mechanics of how damage is dealt is different:
// - 'TemporaryCardDamage': In some games (e.g., Magic:&nbsp;the Gathering), unless the creature has been killed, its health returns to the original value at the end of combat.
// - 'PermanentCardDamage': In other games (e.g., Hearthstone), health damage persists.
//
// Implement classes 'TemporaryCardDamage' and 'PermanentCardDamage' that would allow us to simulate combat between creatures.
// The 'CardGame' class has a template method called 'combat()' which calls the implementation method 'hit()' that needs to appear within both of the derived game classes.

import Foundation

class Creature {
    public var attack, health: Int

    init(_ attack: Int, _ health: Int) {
        self.attack = attack
        self.health = health
    }
}

class CardGame {
    var creatures: [Creature]

    init(_ creatures: [Creature]) {
        self.creatures = creatures
    }

    // the arguments creature1 and creature2 are indices in the 'creatures array'
    //
    // method returns the index of the creature that won the fight
    // returns -1 if there is no clear winner (both alive or both dead)
    func combat(_ creature1: Int, _ creature2: Int) -> Int {
        let first = creatures[creature1]
        let second = creatures[creature2]

        hit(first, second)
        hit(second, first)

        let firstDefeat = first.health <= 0
        let secondDefeat = second.health <= 0

        if firstDefeat == secondDefeat { return -1 }

        return firstDefeat ? creature2 : creature1
    }

    internal func hit(_ attacker: Creature, _ other: Creature) {
        precondition(false, "this method needs to be overridden")
    }
}

class TemporaryCardDamageGame : CardGame {
    override func hit(_ attacker: Creature, _ other: Creature) {
        guard (other.health - attacker.attack) > 0 else {
            other.health = 0
            return
        }
    }
}

class PermanentCardDamage : CardGame {
    override func hit(_ attacker: Creature, _ other: Creature) {
        other.health -= attacker.attack
    }
}
