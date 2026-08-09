@testable import BarkVM
import Testing

@Suite("Environment variables")
struct EnvironmentVariablesTests {
    @Test("An empty environment")
    func emptyEnviroment() {
        #expect(Environment().snapshotGlobals().isEmpty)
    }
    
    @Test("Declare a global in snapshot")
    func declaredGlobalsInSnapshot() throws {
        let environment = Environment()
        try environment.declare(.number(1), as: "x", mutable: false)
        try environment.declare(.truth(.isTrue), as: "y", mutable: true)
        #expect(environment.snapshotGlobals() == ["x":.number(1),
                                          "y":.truth(.isTrue)])
    }
}
