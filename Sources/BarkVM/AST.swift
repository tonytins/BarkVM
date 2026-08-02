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

extension SyntaxExpression: Codable {
    
    static let binaryOperators: Set<String> = ["+", "-", "*", "/", "%", "==", "!=", "<", ">", "<=", ">="]
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        switch self {
        case .numberLiteral(let value):
            try container.encode("num")
            try container.encode(value)
        case .truthLiteral(let value):
            try container.encode("truth")
            try container.encode(value)
        case .variable(let name):
            try container.encode("var")
            try container.encode(name)
        case .binary(let op, let left, let right):
            try container.encode(op)
            try container.encode(left)
            try container.encode(right)
        case .unaryNegation(let operand):
            try container.encode("neg")
            try container.encode(operand)
        }
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let tag = try container.decode(String.self)
        switch tag {
        case "num":
            self = .numberLiteral(try container.decode(Double.self))
        case "truth":
            self = .truthLiteral(try container.decode(TruthValue.self))
        case "var":
            self = .variable(try container.decode(String.self))
        case "neg":
            self = .unaryNegation(try container.decode(SyntaxExpression.self))
        case _ where Self.binaryOperators.contains(tag):
            let left = try container.decode(SyntaxExpression.self)
            let right = try container.decode(SyntaxExpression.self)
            self = .binary(operator: tag, left: left, right: right)
        default:
            throw DecodingError
                .dataCorruptedError(in: container, debugDescription: "Unknown expression tag '\(tag)'")
        }
    }
}

extension Statement: Codable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        switch self {
        case .assignment(let name, let value):
            try container.encode("set")
            try container.encode(name)
            try container.encode(value)
        case .print(let value):
            try container.encode("print")
            try container.encode(value)
        case .conditional(let condition, let thenBranch, let elseBranch):
            try container.encode("if")
            try container.encode(condition)
            try container.encode(thenBranch)
            try container.encode(elseBranch)
        case .whileLoop(let condition, let body):
            try container.encode("while")
            try container.encode(condition)
            try container.encode(body)
        }
    }
}
