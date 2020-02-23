// In this example, we have a class 'Account' that is very tightly coupled to the 'Log'
// protocol...it also breaks SRP by performing all sorts of weird checks in 'someOperations()'
//
// Your mission, should you choose to accept it, is to implement a 'NullLog' class that con be
// fed into an 'Account' and that doesn't throw any exceptions.

protocol Log {
  var recordLimit: Int { get }
  var recordCount: Int { get set }
  func logInfo(_ message: String)
}

enum LogError : Error {
  case recordNotUpdated
  case logSpaceExceeded
}

class Account {
  private var log: Log

  init(_ log: Log) {
    self.log = log
  }

  func someOperation() throws {
    let c = log.recordCount - 1
    log.logInfo("Performing an operation")

    if (c+1) != log.recordCount {
      throw LogError.recordNotUpdated
    }

    if log.recordCount >= log.recordLimit {
      throw LogError.logSpaceExceeded
    }
  }
}

class NullLog : Log {
  var recordLimit: Int { return recordCount + 1 }

  var recordCount: Int {
    get { return 0 }
    set { }
  }

  func logInfo(_ message: String) { }
}