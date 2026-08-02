import Foundation

struct EsoBasicParser {
    let tokens: [Token]
    var position = 0
    
    var current: Token {
        tokens[position]
    }
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    mutating func program() throws -> [Statement] {
        try parseStatements(until: [])
    }
    
    mutating func parseStatements(until terminators: Set<Keyword>) throws -> [Statement] {
        var statements: [Statement] = []
        
        return statements
    }
    
}
