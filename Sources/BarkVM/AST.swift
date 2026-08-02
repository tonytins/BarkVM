public enum TruthValue: String, Codable, Equatable {
    case isTrue = "vera"
    case isFalse = "malvera"
    case isUnknown = "arev"
}

public indirect enum SyntaxExpression {
    case numberLiteral(Double)
    case truthLiteral(TruthValue)
    case variable(String)
    case binary(operator: String, left: SyntaxExpression, right: SyntaxExpression)
    case unaryNegation(SyntaxExpression)
}

public indirect enum Statement {
    case assignment(name: String, value: SyntaxExpression)
    case print(SyntaxExpression)
    case conditional(condition: SyntaxExpression, thenBranch: [Statement], elseBranch: [Statement])
    case whileLoop(condition: SyntaxExpression, body: [Statement])
}
