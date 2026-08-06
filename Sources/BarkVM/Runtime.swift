import Foundation

enum Value {
    case number(Double)
    case truth(TruthValue)
}
extension Value: CustomStringConvertible {
    var description: String {
        switch self {
        case .number(let value):
            value
                .truncatingRemainder(dividingBy: 1) == 0 ? String(Int(value)) : String(value)
        case .truth(let truthValue):
            truthValue.rawValue
        }
    }
}

extension Value: Equatable { }

private struct ReturnSignal: Error {
    let value: Value
}

final class Environment {
    private struct Binding {
        var value: Value
        let isMutable: Bool
    }
    
    private var scopes:  [[String: Binding]] = [[:]]
    
    private var root: Environment? = nil
    
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
        case .undefinedVariable(_):
            ""
        case .undefinedFunction(_):
            ""
        case .alreadyDeclared(_):
            ""
        case .immutableMutation(_):
            ""
        case .typeMismatch(_):
            ""
        case .unsupportedOperator(_):
            ""
        case .divisionByZero:
            ""
        }
    }
}
