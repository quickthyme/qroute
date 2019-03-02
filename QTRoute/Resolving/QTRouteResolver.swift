
public class QTRouteResolver: QTRouteResolving {

    public var route: QTRoute
    private let toChildAction: ActionType.ToChild
    private let toParentAction: ActionType.ToParent
    private let toSelfAction: ActionType.ToSelf

    public init(_ route: QTRoute,
                toChild: @escaping ActionType.ToChild,
                toParent: @escaping ActionType.ToParent,
                toSelf: @escaping ActionType.ToSelf = DefaultAction.ToSelf()) {
        self.route = route
        self.toChildAction = toChild
        self.toParentAction = toParent
        self.toSelfAction = toSelf
    }

    public func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput,
                                    animated: Bool,
                                    completion: @escaping QTRoutableCompletion) {
        toChildAction(route, from, input, animated, completion)
    }

    public func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput,
                                     animated: Bool,
                                     completion: @escaping QTRoutableCompletion) {
        toParentAction(from, input, animated, completion)
    }

    public func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput,
                                   animated: Bool,
                                   completion: @escaping QTRoutableCompletion) {
        toSelfAction(from, input, animated, completion)
    }
}
