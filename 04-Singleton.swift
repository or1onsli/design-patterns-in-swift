// Since implementing a singleton is easy, you have a different challenge:
// write a method called `isSingleton()`. This method takes a lambda (actually, a factory method)
// that returns an object and it's up to you to determine wether or not the object 
// being returned is, in fact, a singleton.

import Foundation

class SingletonTester {
  static func isSingleton(factory: () -> AnyObject) -> Bool {
    let obj1 = factory()
    let obj2 = factory()
    
    return obj1 === obj2
  }
}