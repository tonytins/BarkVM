import Testing
@testable import BarkVM

@Suite("Options")
struct OptionTests {
    @Test
    func someAndNoneAreDistinct() async throws {
        let wrapped: Option<Int> = .some(1)
        let empty: Option<Int> = .none
        
        #expect(wrapped != empty)
    }
}
