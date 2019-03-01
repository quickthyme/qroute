
protocol QTRouteResolving: class {

    // required
    var route: QTRoute { get }
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion)
    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, animated:Bool, completion: @escaping QTRoutableCompletion)

    // optional
    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion)
    static func mergeInputDependencies(target: QTRoutable, input: QTRoutableInput)
}

extension QTRouteResolving {
    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion) {
        Self.mergeInputDependencies(target: from, input: input)
        completion(from)
    }

    static func mergeInputDependencies(target: QTRoutable, input: QTRoutableInput) {
        guard let dependencies = target.routeResolver?.route.dependencies else { return }
        let filteredInput = input.filter { key, val in dependencies.contains(key) }
        target.routeInput = (target.routeInput ?? [:] as QTRoutableInput)
            .merging(filteredInput, uniquingKeysWith: { (_, new) in new })
    }
}
