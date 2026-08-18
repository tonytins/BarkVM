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
    
    // LSL-style state machine
    case state(name: String, body: [Statement])
    case stateTransition(name: String)
}
