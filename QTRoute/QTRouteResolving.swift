
protocol QTRouteResolving: class {
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, completion: @escaping QTRoutableCompletion)
    func resolveRouteToParent(from: QTRoutable, completion: @escaping QTRoutableCompletion)
// optional
    func resolveRouteToSelf(from: QTRoutable, completion: @escaping QTRoutableCompletion)
}

extension QTRouteResolving {
    func resolveRouteToSelf(from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        completion(from)
    }
}
