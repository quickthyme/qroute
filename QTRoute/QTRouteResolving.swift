
protocol QTRouteResolving: class {
    var route: QTRoute { get }
    init(_ route: QTRoute)
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion)
    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion)
// optional
    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion)
}

extension QTRouteResolving {
    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        completion(from)
    }
}
