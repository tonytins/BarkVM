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

public enum Opcode: String, Codable {
    case declare = "let"
    case delcareMut = "mut"
    case mutable = "-"
    case print
    case conditional = "if"
    case whileLoop = "while"
    
    case numberLiteral = "const"
    case boolean = "bool"
    case variable = "val"
    case negate = "neg"
}

extension SyntaxExpression: Codable {
    
    static let binaryOperators: Set<String> = ["+", "-", "*", "/", "%", "==", "!=", "<", ">", "<=", ">="]
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        switch self {
        case .numberLiteral(let value):
            try container.encode(Opcode.numberLiteral)
            try container.encode(value)
        case .truthLiteral(let value):
            try container.encode(Opcode.boolean)
            try container.encode(value)
        case .variable(let name):
            try container.encode(Opcode.variable)
            try container.encode(name)
        case .binary(let op, let left, let right):
            try container.encode(op)
            try container.encode(left)
            try container.encode(right)
        case .unaryNegation(let operand):
            try container.encode(Opcode.negate)
            try container.encode(operand)
        }
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let tag = try container.decode(String.self)
        switch Opcode(rawValue: tag) {
        case .numberLiteral:
            self = .numberLiteral(try container.decode(Double.self))
        case .boolean:
            self = .truthLiteral(try container.decode(TruthValue.self))
        case .variable:
            self = .variable(try container.decode(String.self))
        case .negate:
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
            try container.encode(Opcode.declare)
            try container.encode(name)
            try container.encode(value)
        case .print(let value):
            try container.encode(Opcode.delcareMut)
            try container.encode(value)
        case .conditional(let condition, let thenBranch, let elseBranch):
            try container.encode(Opcode.mutable)
            try container.encode(condition)
            try container.encode(thenBranch)
            try container.encode(elseBranch)
        case .whileLoop(let condition, let body):
            try container.encode(Opcode.whileLoop)
            try container.encode(condition)
            try container.encode(body)
        }
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let tag = try container.decode(String.self)
        switch Opcode(rawValue: tag) {
        case .declare:
            let name = try container.decode(String.self)
            let value = try container.decode(SyntaxExpression.self)
            self = .assignment(name: name, value: value)
        default:
            throw DecodingError
                .dataCorruptedError(in: container, debugDescription: "Unknown expression tag '\(tag)'")
        }
    }
}
