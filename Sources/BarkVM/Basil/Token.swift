
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
