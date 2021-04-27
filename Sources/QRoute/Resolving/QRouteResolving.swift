public protocol QRouteResolving: AnyObject {
    typealias Input = [String:Any]
    typealias Completion = (QRoutable?)->()
    typealias OnInput = (Input)->()

    var route: QRoute { get }
    var input: Input { get set }
    var onInput: OnInput { get set }

    func resolveRouteToChild(_ route: QRoute, from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion)
    func resolveRouteToParent(from: QRoutable, input: Input, animated:Bool, completion: @escaping Completion)
    func resolveRouteToSelf(from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion)

    func mergeInputDependencies(input: Input)
    static func mergeInputDependencies(resolver: QRouteResolving, input: Input)
}

public struct QRouteResolvingInputKey {
    public static let finalDestination = "QRouteResolvingInputKey.finalDestination"
    public static let pathNode = "QRouteResolvingInputKey.pathNode"
}

public extension QRouteResolving {
    func resolveRouteToSelf(from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion) {
        mergeInputDependencies(input: input)
        completion(from)
    }

    func mergeInputDependencies(input: Input) {
        _mergeInputDependencies(self, input)
    }

    static func mergeInputDependencies(resolver: QRouteResolving, input: Input) {
        _mergeInputDependencies(resolver, input)
    }
}

fileprivate func _mergeInputDependencies(_ resolver: QRouteResolving, _ newInput: QRouteResolving.Input) {
    let dependencies = [QRouteResolvingInputKey.finalDestination,
                        QRouteResolvingInputKey.pathNode] + resolver.route.dependencies
    let filteredInput = newInput.filter { key, val in dependencies.contains(key) }
    resolver.input = resolver.input.merging(filteredInput, uniquingKeysWith: { (_, new) in new })
}
