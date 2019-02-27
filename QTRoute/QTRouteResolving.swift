
protocol QTRouteResolving: class {
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion)
    func resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion)
// optional
    func resolveRouteToSelf(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion)
}

extension QTRouteResolving {
    func resolveRouteToSelf(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        completion(from)
    }
}
