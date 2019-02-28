
class QTRouteResolver: QTRouteResolving {
    typealias ToChild  = (QTRoute, QTRoutable, QTRoutableInput, @escaping QTRoutableCompletion) -> ()
    typealias ToParent = (QTRoutable, QTRoutableInput, @escaping QTRoutableCompletion) -> ()
    typealias ToSelf   = (QTRoutable, QTRoutableInput, @escaping QTRoutableCompletion) -> ()

    var route: QTRoute
    private let toChild: ToChild
    private let toParent: ToParent
    private let toSelf: ToSelf

    init(_ route: QTRoute,
         toChild: @escaping ToChild,
         toParent: @escaping ToParent,
         toSelf: @escaping ToSelf = defaultToSelf) {
        self.route = route
        self.toChild = toChild
        self.toParent = toParent
        self.toSelf = toSelf
    }

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput,
                             completion: @escaping QTRoutableCompletion) {
        toChild(route, from, input, completion)
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput,
                              completion: @escaping QTRoutableCompletion) {
        toParent(from, input, completion)
    }

    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput,
                            completion: @escaping QTRoutableCompletion) {
        toSelf(from, input, completion)
    }

    private static var defaultToSelf: ToSelf {
        return { from,input,completion in
            QTRouteResolver.mergeInputDependencies(target: from, input: input)
            completion(from)
        }
    }
}
