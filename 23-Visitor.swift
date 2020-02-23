// You are asked to implement a double-dispatch visitor called 'ExpressionPrinter'
// for printing different mathematical expressions. The range of expressions covers
// addition and multiplication - put round brackets to addition operations and avoid
// blank spaces in the output.


import Foundation

protocol ExpressionVisitor {
    func accept(_ value: Value)
    func accept(_ addition: AdditionExpression)
    func accept(_ multiplication: MultiplicationExpression)
}

protocol Expression {
    func visit(_ visitor: ExpressionVisitor)
}

class Value : Expression {
    let value: Int

    init(_ value: Int) {
        self.value = value
    }

    func visit(_ visitor: ExpressionVisitor) {
        visitor.accept(self)
    }
}

class AdditionExpression : Expression {
    let lhs, rhs: Expression

    init(_ lhs: Expression, _ rhs: Expression) {
        self.lhs = lhs
        self.rhs = rhs
    }

    func visit(_ visitor: ExpressionVisitor) {
        visitor.accept(self)
    }
}

class MultiplicationExpression : Expression {
    let lhs, rhs: Expression

    init(_ lhs: Expression, _ rhs: Expression) {
        self.lhs = lhs
        self.rhs = rhs
    }

    func visit(_ visitor: ExpressionVisitor) {
        visitor.accept(self)
    }
}

class ExpressionPrinter : ExpressionVisitor, CustomStringConvertible {
    private var buffer: String

    init() {
        buffer = ""
    }

    func accept(_ value: Value) {
        buffer.append("\(value.value)")
    }

    func accept(_ addition: AdditionExpression) {
        buffer.append("(")
        addition.lhs.visit(self)
        buffer.append("+")
        addition.rhs.visit(self)
        buffer.append(")")
    }

    func accept(_ multiplication: MultiplicationExpression) {
        multiplication.lhs.visit(self)
        buffer.append("*")
        multiplication.rhs.visit(self)
    }

    var description: String {
        return buffer
    }
}