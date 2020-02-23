// You are given the 'Person' class and asked to write a 'ResponsiblePerson' proxy that does the following:
//
// - Allows person to drink unless they are younger than 18 (in that case, return "too young")
// - Allows person to drive unless they are younger than 16 (otherwise, "too young")
// - In case of driving while drunk returns "dead"
//

import Foundation

protocol UmanBeing {
    func drink() -> String
    func drive() -> String
    func drinkAndDrive() -> String
}

class Person: UmanBeing {
    var age: Int = 0

    func drink() -> String {
        return "drinking"
    }

    func drive() -> String {
        return "driving"
    }

    func drinkAndDrive() -> String {
        return "driving while drunk"
    }
}

class ResponsiblePerson: UmanBeing {
    private let person: Person
    var age: Int

    init(person: Person) {
        self.person = person
        self.age = person.age
    }

    func drink() -> String {
        if self.age < 18 {
            return "too young"
        }

        return person.drink()
    }

    func drive() -> String {
        if self.age < 16 {
            return "too young"
        }

        return person.drive()
    }

    func drinkAndDrive() -> String {
        return "dead"
    }
}
