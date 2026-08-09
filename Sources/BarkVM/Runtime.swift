import Foundation

enum Value: Equatable, Sendable {
    case number(Double)
    case truth(TruthValue)
}

extension Value: CustomStringConvertible {
    var description: String {
        switch self {
        case let .number(value):
            value
                .truncatingRemainder(dividingBy: 1) == 0 ? String(Int(value)) : String(value)
        case let .truth(truthValue):
            truthValue.rawValue
        }
    }
}

private struct ReturnSignal: Error {
    let value: Value
}

final class Environment {
    private struct Binding {
        var value: Value
        let isMutable: Bool
    }

    private var scopes: [[String: Binding]] = [[:]]

    private var root: Environment?

    init() {
        root = nil
    }

    private init(root: Environment) {
        self.root = root
    }

    private var effectiveRoot: Environment {
        root ?? self
    }

    func pushScope() {
        scopes.append([:])
    }

    func popScope() {
        guard scopes.count > 1 else {
            return
        }
        scopes.removeLast()
    }
    
    func snapshotGlobals() -> [String: Value] {
        effectiveRoot.scopes[0].mapValues {
            $0.value
        }
    }

    func value(for name: String) throws -> Value {
        for scope in scopes.reversed() {
            if let binding = scope[name] {
                return binding.value
            }
        }

        if root != nil, let value = effectiveRoot.globalValue(for: name) {
            return value
        }

        throw InterpreterError.undefinedVariable(name)
    }

    func declare(_ value: Value, as name: String, mutable: Bool) throws {
        guard scopes[scopes.count - 1][name] == nil else {
            throw InterpreterError.alreadyDeclared(name)
        }

        scopes[scopes.count - 1][name] = Binding(
            value: value,
            isMutable: mutable,
        )
    }

    private func globalValue(for name: String) -> Value? {
        scopes[0][name]?.value
    }

    private func mutateGlobal(_ value: Value, as name: String) throws -> Bool {
        guard let binding = scopes[scopes.count - 1][name] else {
            return false
        }
        guard binding.isMutable else {
            throw InterpreterError.immutableMutation(name)
        }

        scopes[0][name] = Binding(
            value: value,
            isMutable: true,
        )

        return true
    }
}

final class FunctionTable {
    struct Declaration {
        let parameters: [String]
        let body: [Statement]
    }

    private var functions: [String: Declaration] = [:]

    func declare(name: String, param: [String], body: [Statement]) throws {
        guard functions[name] == nil else {
            throw InterpreterError.alreadyDeclared(name)
        }

        functions[name] = Declaration(parameters: param, body: body)
    }
}

enum InterpreterError: Error, CustomStringConvertible {
    case undefinedVariable(String)
    case undefinedFunction(String)
    case alreadyDeclared(String)
    case immutableMutation(String)
    case typeMismatch(String)
    case unsupportedOperator(String)
    case divisionByZero

    var description: String {
        switch self {
        case .undefinedVariable:
            ""
        case .undefinedFunction:
            ""
        case .alreadyDeclared:
            ""
        case .immutableMutation:
            ""
        case .typeMismatch:
            ""
        case .unsupportedOperator:
            ""
        case .divisionByZero:
            ""
        }
    }
}

struct ExpressionEvaluator {
    let enviroment: Environment
    let callFunction: (String, [Value]) throws -> Value
    
    func evaluate(_ expression: SyntaxExpression) throws -> Value {
        switch expression {
      
        case .numberLiteral(let value):
            return .number(value)
        case .boolean(let value):
            return .truth(value)
        case .variable(let name):
            return try enviroment.value(for: name)
        case .binary(let op, let left, let right):
            return try apply(op,
                             try evaluate(left),
                             try evaluate(right))
        case .unaryNegation(let operand):
            guard case .number(let value) = try evaluate(operand) else {
                throw InterpreterError.typeMismatch("Negation requires a number")
            }
            return .number(-value)
        case .call(let name, let arguments):
            let argumentValues = try arguments.map { try evaluate($0) }
            return try callFunction(name, argumentValues)
        }
    }
    
    func matches(_ a: Value, _ b: Value) -> Bool {
        switch  (a, b) {
        
        default:
            return false
        }
    }
    
    // Unknown compares unknown to anything, including itself
    private func kleeneEquality(_ a: TruthValue, _ b: TruthValue) -> TruthValue {
        guard a != .isUnknown, b != .isUnknown else {
            return .isUnknown
        }
        return a == b ? .isTrue : .isFalse
    }
    
    private func kleeneInequality(_ a: TruthValue, _ b: TruthValue) -> TruthValue {
        switch kleeneEquality(a, b) {
        case .isTrue: return .isFalse
        case .isFalse: return .isTrue
        case .isUnknown: return .isUnknown
        }
    }
    
    private func apply(_ op: String, _ left: Value, _ right: Value) throws -> Value {
        switch (op, left, right) {
        case ("+", .number(let a), .number(let b)): return .number(a + b)
        case ("-", .number(let a), .number(let b)): return .number(a - b)
        case ("*", .number(let a), .number(let b)): return .number(a * b)
        case ("/", .number(let a), .number(let b)):
            guard b != 0 else { throw InterpreterError.divisionByZero }
            return .number(a / b)
        case ("%", .number(let a), .number(let b)):
            guard b != 0 else { throw InterpreterError.divisionByZero }
            return .number(a.truncatingRemainder(dividingBy: b))
        case ("==", .number(let a), .number(let b)): return .truth(a == b ? .isTrue : .isFalse)
        case ("!=", .number(let a), .number(let b)): return .truth(a != b ? .isTrue : .isFalse)
        case ("<", .number(let a), .number(let b)): return .truth(a < b ? .isTrue : .isFalse)
        case (">", .number(let a), .number(let b)): return .truth(a > b ? .isTrue : .isFalse)
        case ("<=", .number(let a), .number(let b)): return .truth(a <= b ? .isTrue : .isFalse)
        case (">=", .number(let a), .number(let b)): return .truth(a >= b ? .isTrue : .isFalse)
        case ("==", .truth(let a), .truth(let b)): return .truth(kleeneEquality(a, b))
        case ("!=", .truth(let a), .truth(let b)): return .truth(kleeneInequality(a, b))
        default:
            throw InterpreterError.unsupportedOperator(op)
        }
    }
}
