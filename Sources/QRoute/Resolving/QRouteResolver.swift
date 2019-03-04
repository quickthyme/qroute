
public final class QRouteResolver: QRouteResolving {

    public var route: QRoute
    private let toChildAction: ActionType.ToChild
    private let toParentAction: ActionType.ToParent
    private let toSelfAction: ActionType.ToSelf

    public init(_ route: QRoute,
                toChild: @escaping ActionType.ToChild,
                toParent: @escaping ActionType.ToParent,
                toSelf: @escaping ActionType.ToSelf = DefaultAction.ToSelf()) {
        self.route = route
        self.toChildAction = toChild
        self.toParentAction = toParent
        self.toSelfAction = toSelf
    }

    public func resolveRouteToChild(_ route: QRoute, from: QRoutable, input: QRoutableInput,
                                    animated: Bool,
                                    completion: @escaping QRoutableCompletion) {
        toChildAction(route, from, input, animated, completion)
    }

    public func resolveRouteToParent(from: QRoutable, input: QRoutableInput,
                                     animated: Bool,
                                     completion: @escaping QRoutableCompletion) {
        toParentAction(from, input, animated, completion)
    }

    public func resolveRouteToSelf(from: QRoutable, input: QRoutableInput,
                                   animated: Bool,
                                   completion: @escaping QRoutableCompletion) {
        toSelfAction(from, input, animated, completion)
    }
}
