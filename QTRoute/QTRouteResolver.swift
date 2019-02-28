
class QTRouteResolver: QTRouteResolving {
    var route: QTRoute
    private let toChild: ResolveToChild
    private let toParent: ResolveToParent
    private let toSelf: ResolveToSelf?

    typealias ResolveToChild  = (QTRoute, QTRoutable, QTRoutableInput, @escaping QTRoutableCompletion) -> ()
    typealias ResolveToParent = (QTRoutable, QTRoutableInput, @escaping QTRoutableCompletion) -> ()
    typealias ResolveToSelf   = (QTRoutable, QTRoutableInput, @escaping QTRoutableCompletion) -> ()

    init(_ route: QTRoute,
         resolveRouteToChild: @escaping ResolveToChild,
         resolveRouteToParent: @escaping ResolveToParent) {
        self.route = route
        self.toChild = resolveRouteToChild
        self.toParent = resolveRouteToParent
        self.toSelf = nil
    }

    init(_ route: QTRoute,
         resolveRouteToChild: @escaping ResolveToChild,
         resolveRouteToParent: @escaping ResolveToParent,
         resolveRouteToSelf: @escaping ResolveToSelf) {
        self.route = route
        self.toChild = resolveRouteToChild
        self.toParent = resolveRouteToParent
        self.toSelf = resolveRouteToSelf
    }

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        toChild(route, from, input, completion)
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        toParent(from, input, completion)
    }

    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        if let toSelf = self.toSelf {
            toSelf(from, input, completion)
        } else {
            QTRouteResolver.mergeInputDependencies(target: from, input: input)
            completion(from)
        }
    }

}
