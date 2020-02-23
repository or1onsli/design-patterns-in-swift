// Consider the quadratic equation and its canonical solution.
// The part b^2-4*a*c is called the discriminant. Suppose we want to provide an API with two different strategies for calculating the discriminant:
//
// - In 'OrdinaryDiscriminantStrategy', if the discriminant is negative, we simply return the discriminant as-is.
// - In 'RealDiscriminantStrategy, if the discriminant is negative, the return value is NaN (not a number). NaN propagates throughout the calculation, so the equation solver gives two NaN values.
//
// Please implement also the equation solver using the '+' solution as first solution and the '-' solution as the second one.

import Foundation

protocol DiscriminantStrategy {
    func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double
}

class OrdinaryDiscriminantStrategy : DiscriminantStrategy {
    func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double {
        return (pow(b, 2) - 4*a*c)
    }
}

class RealDiscriminantStrategy : DiscriminantStrategy {
    func calculateDiscriminant(_ a: Double, _ b: Double, _ c: Double) -> Double {
        let discriminant = (pow(b, 2) - 4*a*c)
        return discriminant > 0 ? discriminant : Double.nan
    }
}

class QuadraticEquationSolver {
    private let strategy: DiscriminantStrategy

    init(_ strategy: DiscriminantStrategy) {
        self.strategy = strategy
    }

    func solve(_ a: Double, _ b: Double, _ c: Double) -> (Double, Double) {
        let discriminant = strategy.calculateDiscriminant(a, b, c)

        guard discriminant != Double.nan else { return (Double.nan, Double.nan) }

        let solutionA = (-b + discriminant.squareRoot()) / (2*a)
        let solutionB = (-b - discriminant.squareRoot()) / (2*a)

        return (solutionA, solutionB)
    }
}