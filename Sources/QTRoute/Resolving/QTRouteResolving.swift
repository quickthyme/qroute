
public protocol QTRouteResolving: class {

    // required
    var route: QTRoute { get }
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion)
    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, animated:Bool, completion: @escaping QTRoutableCompletion)

    // optional
    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion)
    func mergeInputDependencies(target: QTRoutable, input: QTRoutableInput)
    static func mergeInputDependencies(target: QTRoutable, input: QTRoutableInput)
}

public extension QTRouteResolving {
    public func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion) {
        mergeInputDependencies(target: from, input: input)
        completion(from)
    }

    public func mergeInputDependencies(target: QTRoutable, input: QTRoutableInput) {
        _mergeInputDependencies(target, input)
    }

    public static func mergeInputDependencies(target: QTRoutable, input: QTRoutableInput) {
        _mergeInputDependencies(target, input)
    }
}

fileprivate func _mergeInputDependencies(_ target: QTRoutable, _ input: QTRoutableInput) {
    guard let dependencies = target.routeResolver?.route.dependencies else { return }
    let filteredInput = input.filter { key, val in dependencies.contains(key) }
    target.routeInput = (target.routeInput ?? [:] as QTRoutableInput)
        .merging(filteredInput, uniquingKeysWith: { (_, new) in new })
}
