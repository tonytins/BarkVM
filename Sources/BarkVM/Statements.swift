public struct MatchCase: Sendable, Equatable {
    public let pattern: Expression
    public let body: [Statement]
    
    public init(pattern: Expression, body: [Statement]) {
        self.pattern = pattern
        self.body = body
    }
}

public enum Statement: Sendable, Equatable {
    case module(name: String, body: [Statement])
    case function(name: String, parameters: [String], body: [Statement])
    case valueDeclaration(name: String, isMutable: Bool, value: Expression)
    case returnStatement(Expression?)
    case printStatement(Expression)
    case expressionStatement(Expression)
    case assignment(name: String, value: Expression)
    case ifStatement(condition: Expression, thenBranch: [Statement], elseBranch: [Statement])
    case matchStatement(subject: Expression, cases: [MatchCase], defaultBranch: [Statement])
    case tryStatement(body: [Statement], errorName: String, catchBranch: [Statement])
    
    // LSL-style state machine
    case state(name: String, body: [Statement])
    case stateTransition(name: String)
}
