import Testing
@testable import BarkVM

@Suite("Trillean")
struct TrileanTests {
    
    @Test(arguments: Array(
        zip(
            [Trilean.isTrue, .isFalse, .isUnknown],
            ["true", "false", "Unknown"]
        )))
    func valueMatchesCase(value: Trilean, expected: String) async throws {
        #expect(value.rawValue == expected)
    }
    
}
