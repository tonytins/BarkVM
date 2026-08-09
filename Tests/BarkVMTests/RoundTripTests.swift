@testable import BarkVM
import Foundation
import Testing

// These merely test the very concept of a AST -> JSON IR -> AST pipeline

@Suite("Round Trip Tests")
struct RoundTripTests {
    private func roundTrip<T: Codable>(_ value: T, json expectedJSON: String) throws {
        let data = try JSONEncoder().encode(value)
        #expect(String(data: data, encoding: .utf8) == expectedJSON)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        let reEncoded = try JSONEncoder().encode(decoded)
        #expect(String(data: reEncoded, encoding: .utf8) == expectedJSON)
    }
    
    @Test("Function round-trips through IR")
    func functionRoundTrips() throws {
        let statement = Statement.function(
            name: "add", parameters: ["a", "b"],
            body: [.returnStatement(
                .binary(operator: "+", left: .variable("a"), right: .variable("b")))]
        )
        try roundTrip([statement], json: #"[["fn","add",["a","b"],[["return",["+",["val","a"],["val","b"]]]]]]"#)
    }
    
    @Test("Module delceration round-trips through IR")
    func declareModuleRoundTrip() throws {
        let statement = Statement.moduleDeclaration(
            name: "Utility",
            functions: [.function(
                name: "double",
                parameters: ["x"],
                body: [.returnStatement(.binary(operator: "*", left: .variable("x"), right: .numberLiteral(2)))]
                )]
            )
            try roundTrip(
                [statement],
                json: #"[["mod","Utility",[["fn","double",["x"],[["return",["*",["val","x"],["num",2]]]]]]]]"#
            )
    }
}
