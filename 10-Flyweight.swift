// You are given a class called 'Sentence', which takes a string such as "hello world".
// You need to provide an interface such that the subscript of the class returns a 'WordToken'
// which can be used to capitalize a particular word in the sentence.
//
// Typical use would be something like:
//
// 1| var sentence = Sentence("hello world")
// 2| sentence[1].capitalize = true
// 3| print(sentence) /* <--- writes "hello WORLD" */

import Foundation

class Sentence : CustomStringConvertible {
    private var text: [String]
    private var tokens = [Int: WordToken]()

    init(_ plainText: String) {
        self.text = plainText.components(separatedBy:" ")
    }

    subscript(index: Int) -> WordToken {
        get {
            let token = WordToken()
            tokens[index] = token
            return tokens[index]!
        }
    }

    var description: String {
        var words = [String]()

        for i in 0..<text.count {
            var word = text[i]

            if let item = tokens[i], item.capitalize == true {
                word = word.uppercased()
            }

            words.append(word)
        }

        return words.joined(separator:" ")
    }

    class WordToken {
        var capitalize: Bool = false
        
        init() {}

        init(capitalize: Bool) {
            self.capitalize = capitalize
        }
    }
}
