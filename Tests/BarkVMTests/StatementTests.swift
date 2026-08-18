import Testing
@testable import BarkVM

@Suite("Statements and expressions")
struct StatementTests {
    @Test(arguments: ["pet", "feed", "sleep"])
    func stateMachineTransitionI(states: String) {
        let statement = Statement.stateTransition(name: states)
        #expect(statement == .stateTransition(name: states))
    }
    
    @Test func matchBuildsCaseAndDefault() {
        let statement = Statement.matchStatement(
            subject: .identifier("counter"),
            cases: [
                MatchCase(pattern: .numberLiteral(0), body:
                            [.printStatement(.stringLiteral("zero"))])
            ],
            defaultBranch: [.printStatement(.stringLiteral("many"))]
        )
        
        guard case .matchStatement(_, let cases, let defaultBranch) = statement else {
            Issue.record("Expected .matchStatement")
            return
        }
        
        #expect(cases.count == 1)
        #expect(defaultBranch == [.printStatement(.stringLiteral("many"))])
    }
}
