import Foundation

public enum Keyword: String {
    case estu // let
    case montru // show (i.e. print)
    case se // if
    case tiam // then
    case alie // else
    case finse // end if
    case dum // while
    case findum // end while
    case por // for
    case de // from
    case al // to
    case finpor // end  for
    case vera // true
    case malvera // false
}

enum Token: Equatable {
    case keyword(Keyword)
    case identifier(String)
    case number(Double)
    case operatorSymbol(String)
    case punctuation(String)
    case newline
    case endOfInput
}


enum LexingError: Error, CustomStringConvertible {
    case unexpectedCharacter(Character, at: Int)
    case malformedNumber(String)
    
    var description: String {
        switch self {
        case .unexpectedCharacter(let character, let index):
            return "Unexpected character \(character) at position \(index)"
        case .malformedNumber(let text):
            return "Malformed number literal \(text)"
        }
    }
}


struct EsoBasicLexer {
    private static let remarkKeyword = "rimarko"
    
    func tokens(from source: String) throws -> [Token] {
        let characters = Array(source)
        var index = 0
        var tokens: [Token] = []
        
        while index < characters.count {
            let character = characters[index]
            switch character {
            case " ", "\t", "\r":
                index += 1
            case "\n":
                tokens.append(.newline)
                index += 1
            default:
                throw LexingError.unexpectedCharacter(character, at: index)
            }
        }
        
        tokens.append(.endOfInput)
        return tokens
    }
    
    private func normalizedLineEndings(in source: String) -> String {
        source
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
    }
    
    func startLineComment(_ characters: [Character], at index: Int) -> Bool {
        if characters[index] == "#" { return true }
        return matchesStandaloneWord(
            Self.remarkKeyword,
            in: characters,
            at: index
        )
    }
    
    func matchesStandaloneWord(_ word: String, in characters: [Character], at index: Int) -> Bool {
        
        return true
    }
    
    
    func sanitized(_ source: String) -> String {
        let normalized = normalizedLineEndings(in: source)
        let characters = Array(normalized)
        var result = ""
        result.reserveCapacity(characters.count)
        var index = 0
        
        while index < characters.count {
            if startLineComment(characters, at: index) {
                index = endOfLine(characters, from: index)
                continue
            }
            result.append(characters[index])
            index += 1
        }
        
        return ""
    }
    
    func endOfLine(_ characters: [Character],
                       from start: Int)  -> Int {
        var index = start
        while index < characters.count, characters[index] != "\n" {
            index += 1
        }
        return index
    }
}
