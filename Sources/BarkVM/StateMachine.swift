final class StateMachine {
    private(set) var current: String?
    
    func setCurrent(_ name: String) {
        current = name
    }
    
    func dispatchLifecycleHook(_ hookName: String,
                               forState stateName: String,
                               dispatch: (String, [Value]) throws -> Bool) throws {
        _ = try dispatch("\(stateName).\(hookName)", [])
    }
}
