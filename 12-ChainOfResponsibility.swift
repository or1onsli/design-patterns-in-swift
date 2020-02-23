// You are given a game scenario with classes Goblin and GoblinKing. Please implement the following rules:
// - A goblin has base 1 attack/1 defense (1/1), a goblin king is 3/3.
// - When the Goblin King is in play, every other goblin gets +1 Attack.
// - Goblins get +1 to Defense for every other Goblin in play (a GoblinKing is a Goblin!).
//
// Example:
// - Suppose you have 3 ordinary goblins in play. Each one is a 1/3 (1/1 + 0/2 defense bonus).
// - A goblin king comes into play. Now every ordinary goblin is a 2/4 (1/1 + 0/3 defense bonus from each other + 1/0 from goblin king)
//
// The state of all the goblins has to be consistent as goblins are added to the game.
//

import Foundation

class Creature {
    let baseAttack: Int
    let baseDefense: Int
    let game: Game

    init(game: Game, baseAttack: Int, baseDefense: Int) {
        self.game = game
        self.baseAttack = baseAttack
        self.baseDefense = baseDefense
    }

    var attack: Int {
        get { return baseAttack }
    }

    var defense: Int {
        get { return baseDefense }
    }

    func query(_ source: AnyObject, _ query: StatQuery) {}
}

class Goblin : Creature {

    convenience init(game: Game) {
        self.init(game: game, baseAttack: 1, baseDefense: 1)
    }

    override func query(_ source: AnyObject, _ query: StatQuery) {
        if (source === self) {
            switch query.statistic {
            case .attack: query.result += baseAttack
            case .defense: query.result += baseDefense
            }
        } else {
            // a Goblin gets +1 def for every other goblin in play
            if (query.statistic == .defense) {
                query.result += 1
            }
        }
    }

    override var attack: Int {
        get {
            let query = StatQuery(.attack)

            for creature in game.creatures {
                creature.query(self, query)
            }

            return query.result
        }
    }

    override var defense: Int {
        get {
            let query = StatQuery(.defense)

            for creature in game.creatures {
                creature.query(self, query)
            }

            return query.result
        }
    }
}

class GoblinKing : Goblin {
    convenience init(game: Game) {
        self.init(game: game, baseAttack: 3, baseDefense: 3)
    }

    override func query(_ source: AnyObject, _ query: StatQuery) {
        if (source !== self && query.statistic == .attack) {
            query.result += 1
        } else {
            // the king is also a goblin, so...
            super.query(source, query)
        }
    }
}

class Game {
    var creatures = [Creature]()
}

enum Statistic {
    case attack
    case defense
}

class StatQuery {
    var statistic: Statistic
    var result: Int = 0

    init(_ statistic: Statistic) {
        self.statistic = statistic
    }
}