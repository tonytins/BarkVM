@testable import BarkVM
import Foundation
import Testing

// This is purely meant to test out the everything works

enum ScriptKeywords: String {
    case test
    case val
    case mut
    case asset
    case printStatement = "print"
}

enum ScriptTokens: Equatable {
    case keyword(ScriptKeywords)
    case identifier(String)
    case number(Double)
    case newline
}

struct TestScript {
    private func normalizedLineEndings(in source: String) -> String {
        source
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
    }
}
