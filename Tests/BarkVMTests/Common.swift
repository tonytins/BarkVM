@testable import BarkVM
import Testing

private extension SyntaxExpression {
    func isEqual(to other: SyntaxExpression) -> Bool {
        switch (self, other) {
        case (.numberLiteral(let a), .numberLiteral(let b)):
            return a == b
        case (.boolean(let a), .boolean(let b)):
            return a == b
        case (.variable(let a), .variable(let b)):
            return a == b
        case (.unaryNegation(let a), .unaryNegation(let b)):
            return a.isEqual(to: b)
        case (.binary(let opA, let leftA, let rightA), .binary(let opB, let leftB, let rightB)):
            return opA == opB && leftA.isEqual(to: leftB) && rightA.isEqual(to: rightB)
        case (.call(let nameA, let argumentsA), .call(let nameB, let argumentsB)):
            return nameA == nameB
            && argumentsA.count == argumentsB.count
            && zip(argumentsA, argumentsB).allSatisfy { $0.isEqual(to: $1) }
        default:
            return false
        }
    }
}
