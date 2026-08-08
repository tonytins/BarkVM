import Foundation


protocol LanguageFrontend {
    func parseProgram(_ source: String) throws -> [Statement]
}

public enum StringScanningError: Error, CustomStringConvertible, Sendable {
    case unterminatedString(at: Int)
    case invalidEscapeSequence(Character, at: Int)
    
    public var description: String {
        switch self {
        case .unterminatedString(let startIndex):
            return ""
        case .invalidEscapeSequence(let character, let index):
            return ""
        }
    }
}

// Scans for quotes shared by every lexer in this project.
public enum StringScanning {
    public struct Result: Sendable {
        public let value: String
        public let endIndex: Int   // index of the character just past the closing quote
    }
    
    public static func scan(_ characters: [Character], from startIndex: Int) throws -> Result {
        var index = startIndex + 1
        var value = ""
        
        while index < characters.count {
            let character = characters[index]
            
            switch character {
            case "\"":
                return Result(value: value, endIndex: index + 1)
            default:
                value.append(character)
                index += 1
            }
        }
        
        throw StringScanningError.unterminatedString(at: startIndex)
    }
}
