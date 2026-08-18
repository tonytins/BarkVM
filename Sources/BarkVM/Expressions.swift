public enum BinaryOperator: Sendable, Equatable {
    case add
    case subtract
    case multiply
    case divide
    case equal
    case notEqual
    case and
    case or
}

public enum Expression: Sendable, Equatable {
    case numberLiteral(Double)
    case stringLiteral(String)
    case boolLiteral(Bool)
    case trileanLiteral(Trilean)
    case noneLiteral
    case identifier(String)
    indirect case numberAcess(base: Expression, member: String)
    indirect case call(callee: Expression, arguments: [Expression])
    indirect case binary(
        operator: BinaryOperator,
        lefT: Expression,
        right: Expression
    )
}
