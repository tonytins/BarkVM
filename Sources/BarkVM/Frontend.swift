import Foundation


public protocol LanguageFrontend {
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
    
    private static let lineEndings = ["\u{000A}", "\u{000D}",
                                      "\u{000D}\u{000A}", "\u{2028}"]
    
    public static func scan(_ characters: [Character], from startIndex: Int) throws -> Result {
        
        
        throw StringScanningError.unterminatedString(at: startIndex)
    }
}

public extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
