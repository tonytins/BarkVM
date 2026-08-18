public struct Lexer {
    public static func tokenize(_ source: String) throws -> [Token] {
        var scanner = Scanner(source: source)
        return try scanner.tokenize()
    }
}

public struct LexError: Error, Equatable, Sendable {
    public let message: String
    public let line: Int
    
    public init(message: String, line: Int) {
        self.message = message
        self.line = line
    }
}

public struct Scanner {
    private let characters: [Character]
    private var index = 0
    private var line = 1
    
    private var isAtEnd: Bool { index >= characters.count }
    private var current: Character { characters[index] }
    
    init(source: String) {
        characters = Array(source)
    }
    
    private func peek(offset: Int = 1) -> Character? {
        let peekIndex = index + offset
        guard peekIndex < characters.count else {
            return nil
        }
        return characters[peekIndex]
    }
    
    private func classify(_ word: String) -> TokenKind {
        guard word != "_" else {
            return .symbol(.underscore)
        }
        
        guard let keyword = Keyword(rawValue: word) else {
            return .identifier(word)
        }
        
        return .keyword(keyword)
    }
    
    private mutating func advance() {
        index += 1
    }
    
    private mutating func skipWhiteSpaceAndComments() {
        while !isAtEnd {
            if current == "\n" {
                line += 1
                advance()
                continue
            }
            
            if current.isWhitespace {
                advance()
                continue
            }
            
            if current == "#" {
                
            }
        }
    }
    
    private mutating func skipToEndOfLine() {
        while !isAtEnd, current != "\n" {
            advance()
        }
    }
    
    mutating func tokenize() throws -> [Token] {
        var tokens: [Token] = []
        
        while true {
            
        }
        
        tokens.append(Token(kind: .endOfInput, line: line))
        return tokens
    }
}
