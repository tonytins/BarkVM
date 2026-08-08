import ArgumentParser
import BarkVM
import Foundation

public protocol OutputSink: AnyObject {
    func write(_ line: String)
}

public final class CollectingOutput: OutputSink {
    public private(set) var lines: [String] = []

    public init() {}

    public func write(_ line: String) {
        lines.append(line)
    }
}

public final class ConsoleOutput: OutputSink {
    public init() {}

    public func write(_ line: String) {
        print(line)
    }
}

public protocol LanguageFrontend {
    func parse(_ source: String) throws -> [Statement]
}

public enum VM {
    /// Compiles the source down to the JSON intermediate representation,
    public static func compileToIR(
        _ source: String,
        using frontend: LanguageFrontend,
        fancy _: Bool = false,
    ) throws -> Data {
        let statements = try frontend.parse(source)
        let encoder = JSONEncoder()
        return try encoder.encode(statements)
    }
}

@main
struct Program: ParsableCommand {
    @Argument var source: String

    @Flag var Ir = false

    mutating func run() throws {
        switch Ir {
        case true:
            // VM.compileToIR(source, using: )
            break
        default:
            break
        }

        print("Hello, world!")
    }
}
