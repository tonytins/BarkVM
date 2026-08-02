import Foundation

public protocol LanguageParser {
    mutating func program() throws -> [Statement]
    
    mutating func parse(until terminators: Set<Keyword>) throws -> [Statement]
}


public protocol LanguageFrontend {
    func parse(_ source: String) throws -> [Statement]
}
