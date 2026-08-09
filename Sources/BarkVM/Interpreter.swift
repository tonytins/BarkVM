import Foundation

enum ProgramError: Error, CustomStringConvertible {
    case multipleEntryPoints
    
    var description: String {
        switch self {
        case .multipleEntryPoints:
             "Found main and state default, only one entry point can exist"
        }
    }
}

struct Interpreter {
    let output: OutputSink
    
    enum EntryPoint: Equatable {
        case main
        case stateMachine
    }
    
    // TODO: look into cleaning this up
    private static func hasMain(in statements: [Statement]) -> Bool {
        statements.contains {
            statement in
            if case .function(let name, _, _) = statement, name == "main" { return true }
            return false
        }
    }
    
    private static func hasDefaultState(in statements: [Statement]) -> Bool {
        statements.contains {
            statement in
            if case .stateDeclaration(let name, _) = statement, name == "default" { return true }
            return false
        }
    }
    
    static func resolveEntryPoint(
        in statements: [Statement]
    ) throws -> EntryPoint? {
        let isMain = hasMain(in: statements)
        let isDefaultState = hasDefaultState(in: statements)
        
        
        guard isMain && isDefaultState else {
            throw ProgramError.multipleEntryPoints
        }
        
        
        if isMain {
            return .main
        }
        
        if isDefaultState {
            return .stateMachine
        }
        
        return nil
    }
}
