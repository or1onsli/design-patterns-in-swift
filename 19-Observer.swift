// Imagine a game where one or more rats can attack a player.
// Each individual rat has an 'attack' value of 1. However, rats attack as a swarm,
// so each rat's 'attack' value is equal to the total number of rats in play.
//
// Givern that a rat enters play through the constructor and leaves play (dies) via
// its 'kill()' method (rat murder is satisfying!), please implement the 'Game' and
// 'Rat' classes so that, at any point in the game, the 'attack' value of a rat is always
// consistent.
//
// The exercise has two simple rules:
// - The Game class cannot contain properties. It can only contain events and methods.
// - The rat class' attack property is strictly defined as 'var attack = 1', i.e. it
//   doesn't have a custom getter or setter.

import Foundation

protocol Invocable : class {
    func invoke(_ data: Any)
}

public protocol Disposable {
    func dispose()
}

public class Event<T> {
    public typealias EventHandler = (T) -> ()
    var eventHandlers = [Invocable]()

    public func raise(_ data: T) {
        for handler in self.eventHandlers {
            handler.invoke(data)
        }
    }

    public func addHandler<U: AnyObject>
        (target: U, handler: @escaping (U) -> EventHandler) -> Disposable {
        let subscription = Subscription(target: target, handler: handler, event: self)
        eventHandlers.append(subscription)
        return subscription
    }
}

class Subscription<T: AnyObject, U> : Invocable, Disposable {
    weak var target: T?
    let handler: (T) -> (U) -> ()
    let event: Event<U>

    init(target: T?, handler: @escaping (T) -> (U) -> (), event: Event<U>) {
        self.target = target
        self.handler = handler
        self.event = event
    }

    func invoke(_ data: Any) {
        if let t = target {
            handler(t)(data as! U)
        }
    }

    func dispose() {
        event.eventHandlers = event.eventHandlers.filter { $0 as AnyObject? !== self }
    }
}

class Game {
    var ratEnters = Event<AnyObject>()
    var ratDies   = Event<AnyObject>()
    var notifyRat = Event<(AnyObject,Rat)>()

    func fireRatEnters(_ sender: AnyObject) {
        ratEnters.raise(sender)
    }

    func fireRatDies(_ sender: AnyObject) {
        ratDies.raise(sender)
    }

    func fireNotifyRat(_ sender: AnyObject, _ whichRat: Rat) {
        notifyRat.raise((sender, whichRat))
    }
}

class Rat {
    private let game: Game
    var attack = 1

    init(_ game: Game) {
        self.game = game

        game.ratEnters.addHandler(target: self, handler: {
            (_) -> ((AnyObject)) -> () in
            return {
                if $0 !== self {
                    self.attack += 1
                    game.fireNotifyRat(self, $0 as! Rat)
                }
            }
        })

        game.ratDies.addHandler(target: self, handler: {
            (_) -> ((AnyObject)) -> () in
            return {
                if $0 !== self {
                    self.attack -= 1
                }
            }
        })

        game.notifyRat.addHandler(target: self, handler: {
            (_) -> ((AnyObject, Rat)) -> () in
            return {
                if $0.1 === self {
                    self.attack += 1
                }
            }
        })

        game.fireRatEnters(self)
    }

    func kill() {
        game.fireRatDies(self)
    }
}