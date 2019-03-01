
class QTRouteResolver: QTRouteResolving {
    typealias ToChild  = (QTRoute, QTRoutable, QTRoutableInput, Bool, @escaping QTRoutableCompletion) -> ()
    typealias ToParent = (QTRoutable, QTRoutableInput, Bool, @escaping QTRoutableCompletion) -> ()
    typealias ToSelf   = (QTRoutable, QTRoutableInput, Bool, @escaping QTRoutableCompletion) -> ()

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
                             animated: Bool,
                             completion: @escaping QTRoutableCompletion) {
        toChild(route, from, input, animated, completion)
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput,
                              animated: Bool,
                              completion: @escaping QTRoutableCompletion) {
        toParent(from, input, animated, completion)
    }

    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput,
                            animated: Bool,
                            completion: @escaping QTRoutableCompletion) {
        toSelf(from, input, animated, completion)
    }

    private static var defaultToSelf: ToSelf {
        return { from,input,_,completion in
            QTRouteResolver.mergeInputDependencies(target: from, input: input)
            completion(from)
        }
    }
}
