// The following code scenario shows a 'Dragon' which is both a 'Bird' and a 'Lizard'.
// Complete the Dragon's interface (there's no need to extract protocols out of either
// 'Bird' or 'Lizard'). Take special care when implementing the 'age' property!

import Foundation

class Bird {
    var age = 0

    func fly() -> String {
        return (age < 10) ? "flying" : "too old"
    }
}

class Lizard {
    var age = 0

    func crawl() -> String {
        return (age > 1) ? "crawling" : "too young"
    }
}

// Solution
class Dragon {
    private let bird = Bird()
    private let lizard = Lizard()

    var age: Int {
        set {
            bird.age = newValue
            lizard.age = newValue
        }
        get {
            return age
        }
    }

    func fly() -> String {
        return bird.fly()
    }

    func crawl() -> String {
        return lizard.crawl()
    }
}
