import Foundation

struct EsoBasicParser: LanguageParser {
        let tokens: [Token]
    var position = 0
    
    var current: Token {
        tokens[position]
    }
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    public mutating func program() throws -> [Statement] {
        try parse(until: [])
    }
    
    mutating func parse(until terminators: Set<Keyword>) throws -> [Statement] {
        var statements: [Statement] = []
        
        return statements
    }
    
    
}

/* public struct EsoBasic: LanguageFrontend {

    public init() {}
    
    public func parse(_ source: String) throws -> [Statement] {
        let tokens = try EsoBasicLexer().tokens(from: source)
        let parser = EsoBasic()
        
        return try parser.
    }
    
} */
