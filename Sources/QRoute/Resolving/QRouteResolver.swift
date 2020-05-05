public final class QRouteResolver: QRouteResolving {

    public init(_ route: QRoute,
                toChild: @escaping ActionType.ToChild,
                toParent: @escaping ActionType.ToParent,
                toSelf: @escaping ActionType.ToSelf = DefaultAction.ToSelf(),
                onInput: OnInput? = nil) {
        self.route = route
        self.toChildAction = toChild
        self.toParentAction = toParent
        self.toSelfAction = toSelf
        if let oi = onInput { self.onInput = oi }
    }

    public var route: QRoute

    public var onInput: OnInput = { _ in }

    public var input: Input = [:] {
        didSet { self.onInput(self.input) }
    }

    private let toChildAction: ActionType.ToChild
    private let toParentAction: ActionType.ToParent
    private let toSelfAction: ActionType.ToSelf


    public func resolveRouteToChild(_ route: QRoute, from: QRoutable, input: Input,
                                    animated: Bool,
                                    completion: @escaping Completion) {
        toChildAction(route, from, input, animated, completion)
    }

    public func resolveRouteToParent(from: QRoutable, input: Input,
                                     animated: Bool,
                                     completion: @escaping Completion) {
        toParentAction(from, input, animated, completion)
    }

    public func resolveRouteToSelf(from: QRoutable, input: Input,
                                   animated: Bool,
                                   completion: @escaping Completion) {
        toSelfAction(from, input, animated, completion)
    }
}
