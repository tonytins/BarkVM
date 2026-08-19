/// SQL-inspired third value
public enum Trilean: String, Sendable, Equatable, Decodable {
    case isTrue = "true"
    case isFalse = "false"
    case isUnknown = "Unknown"
}
