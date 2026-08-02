import Foundation

public protocol LanguageFrontend {
    func parseProgram(_ source: String) throws -> [Statement]
}

// TODO: EsoBasic still needs fleshing out
/*
public struct EsoBasic: LanguageFrontend {
   
    public init() {}
    
  public func parseProgram(_ source: String) throws -> [Statement] {
        let tokens = try EsoBasicLexer().tokens(from: source)
        let parser = EsoBasic()
        
        return try parser.program()
    }
}
 */
