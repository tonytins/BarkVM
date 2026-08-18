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
    
    init(source: String) {
        characters = Array(source)
    }
    
    mutating func tokenize() throws -> [Token] {
        var tokens: [Token] = []
        
        
        tokens.append(Token(kind: .endOfInput, line: line))
        return tokens
    }
}

public struct Token: Sendable, Equatable {
    public let kind: TokenKind
    public let line: Int
    
    public init(kind: TokenKind, line: Int) {
        self.kind = kind
        self.line = line
    }
}


public enum TokenKind: Sendable, Equatable {
    case keyword(Keyword)
    case identifier(String)
    case numberLiteral(Double)
    case stringLiteral(String)
    case symbol(Symbol)
    case endOfInput
}

public enum Keyword: String, Sendable, Equatable, CaseIterable {
    case mod
    case state
    case end
    case funcKeyword = "func"
    case val
    case mut
    case ifKeyword = "if"
    case elseKeyword = "else"
    case match
    case caseKeyword = "case"
    case tryKeyword = "try"
    case catchKeyword = "catch"
    case print
    case returnKeyword = "return"
    case trueKeyword = "true"
    case falseKeyword = "false"
    case unknownKeyword = "Unknown"
    case noneKeyword = "None"
}

public enum Symbol: String, Sendable, Equatable, CaseIterable {
    case leftParenthesis = "("
    case rightParenthesis = ")"
    case comma = ","
    case dot = "."
    case plus = "+"
    case minus = "-"
    case asterisk = "*"
    case slash = "/"
    case equalEqual = "=="
    case notEqual = "!="
    case andAnd = "&&"
    case orOr = "||"
    case not = "!"
    case equal = "="
    case underscore = "_"
}
