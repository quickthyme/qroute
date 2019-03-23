

public protocol QRouteResolving: class {
    typealias Input = [String:Any]
    typealias Completion = (QRoutable?)->()
    typealias OnInput = (Input)->()
    var route: QRoute { get }
    var input: Input { get set }
    var onInput: OnInput { get set }
    func resolveRouteToChild(_ route: QRoute, from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion)
    func resolveRouteToParent(from: QRoutable, input: Input, animated:Bool, completion: @escaping Completion)
    func mergeInputDependencies(input: Input)
    static func mergeInputDependencies(resolver: QRouteResolving, input: Input)

    // optional
    func resolveRouteToSelf(from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion)
}

public extension QRouteResolving {
    public func resolveRouteToSelf(from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion) {
        mergeInputDependencies(input: input)
        completion(from)
    }

    public func mergeInputDependencies(input: Input) {
        _mergeInputDependencies(self, input)
    }

    public static func mergeInputDependencies(resolver: QRouteResolving, input: Input) {
        _mergeInputDependencies(resolver, input)
    }
}

fileprivate func _mergeInputDependencies(_ resolver: QRouteResolving, _ newInput: QRouteResolving.Input) {
    let dependencies = resolver.route.dependencies
    let filteredInput = newInput.filter { key, val in dependencies.contains(key) }
    resolver.input = resolver.input.merging(filteredInput, uniquingKeysWith: { (_, new) in new })
}
