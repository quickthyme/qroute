
public protocol QRouteResolving: class {

    // required
    var route: QRoute { get }
    func resolveRouteToChild(_ route: QRoute, from: QRoutable, input: QRoutableInput, animated: Bool, completion: @escaping QRoutableCompletion)
    func resolveRouteToParent(from: QRoutable, input: QRoutableInput, animated:Bool, completion: @escaping QRoutableCompletion)

    // optional
    func resolveRouteToSelf(from: QRoutable, input: QRoutableInput, animated: Bool, completion: @escaping QRoutableCompletion)
    func mergeInputDependencies(target: QRoutable, input: QRoutableInput)
    static func mergeInputDependencies(target: QRoutable, input: QRoutableInput)
}

public extension QRouteResolving {
    public func resolveRouteToSelf(from: QRoutable, input: QRoutableInput, animated: Bool, completion: @escaping QRoutableCompletion) {
        mergeInputDependencies(target: from, input: input)
        completion(from)
    }

    public func mergeInputDependencies(target: QRoutable, input: QRoutableInput) {
        _mergeInputDependencies(target, input)
    }

    public static func mergeInputDependencies(target: QRoutable, input: QRoutableInput) {
        _mergeInputDependencies(target, input)
    }
}

fileprivate func _mergeInputDependencies(_ target: QRoutable, _ input: QRoutableInput) {
    guard let dependencies = target.routeResolver?.route.dependencies else { return }
    let filteredInput = input.filter { key, val in dependencies.contains(key) }
    target.routeInput = (target.routeInput ?? [:] as QRoutableInput)
        .merging(filteredInput, uniquingKeysWith: { (_, new) in new })
}
