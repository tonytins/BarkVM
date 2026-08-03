import Foundation

public protocol OutputSink: AnyObject {
    func write(_ line: String)
}

public final class CollectingOutput: OutputSink {
    public private(set) var lines: [String] = []
    
    public init() { }
    
    public func write(_ line: String) {
        lines.append(line)
    }
}

public final class ConsoleOutput: OutputSink {
    public init() { }
    
    public func write(_ line: String) {
        print(line)
    }
}

public enum BarkVM {
    /// Compiles the source down to the JSON intermediate representation,
    public static func compileToIR(
        _ source: String,
        using frontend: LanguageFrontend,
        fancy: Bool = false
    ) throws -> Data {
        let statements = try frontend.parse(source)
        let encoder = JSONEncoder()
        return try encoder.encode(statements)
    }
}
