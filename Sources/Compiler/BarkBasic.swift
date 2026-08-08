enum BarkBasicKeywords: String {
    case mutable 
    case variable
    case print
    case ifStatement
    case thenStatement
    case elseStatement
    case whileStatement
    case switchStatement
    case caseStatement
    case function
    case returnStatement
    case module
    case state
    case trueStatement
    case falseStatement
    case unknown
    case end
}


enum BarkBasicToken: Equatable {
    case keyword(BarkBasicKeywords)
    case identifier(String)
    case number(Double)
    case operatorSymbol(String)
    case punctuation(Character)
    case newline
    case endOfInput
}
