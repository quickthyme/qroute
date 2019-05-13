import QRoute

public class QRouteTestVerifier {

    public func reset() {
        timesCalled = [:]
        valueFor = [:]
    }

    public func getTimesCalled(_ function: String) -> Int {
        return timesCalled[function] ?? 0
    }

    public func getArgument(_ function: String, _ parameter: String) -> Any? {
        return valueFor[function]![parameter]
    }

    internal var timesCalled: [String:Int] = [:]

    internal var valueFor: [String:[String:Any]] = [:]

    internal func record(_ function: String, _ arguments: (String, Any?)...) {
        incrTimesCalled(function)
        setValuesFor(function, arguments)
    }

    private func incrTimesCalled(_ function: String) {
        timesCalled[function] = (timesCalled[function] ?? 0) + 1
    }

    private func setValuesFor(_ function: String, _ arguments: [(String, Any?)]) {
        if (valueFor[function] == nil) { valueFor[function] = [:] }
        for (param, val) in arguments {
            guard let val = val else { continue }
            valueFor[function]![param] = val
        }
    }
}
