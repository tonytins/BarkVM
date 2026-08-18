public enum Option<Wrapped: Sendable>: Sendable {
    case some(Wrapped)
    case none
}

extension Option: Equatable where Wrapped: Equatable {}

public enum Result<Success: Sendable, Failure: Error & Sendable>: Sendable
{
    case success(Success)
    case failure(Failure)
}

extension Result: Equatable where Success: Equatable, Failure: Equatable {}
