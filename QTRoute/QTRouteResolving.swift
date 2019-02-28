
protocol QTRouteResolving: class {

    // required
    var route: QTRoute { get }
    init(_ route: QTRoute)
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion)
    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion)

    // optional
    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion)
    func mergeInputDependencies(target: QTRoutable, input: QTRoutableInput)
}

extension QTRouteResolving {
    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        mergeInputDependencies(target: from, input: input)
        completion(from)
    }

    func mergeInputDependencies(target: QTRoutable, input: QTRoutableInput) {
        guard let dependencies = target.routeResolver?.route.dependencies else { return }
        let filteredInput = input.filter { key, val in dependencies.contains(key) }
        target.routeInput = (target.routeInput ?? [:] as QTRoutableInput)
            .merging(filteredInput, uniquingKeysWith: { (_, new) in new })
    }
}
