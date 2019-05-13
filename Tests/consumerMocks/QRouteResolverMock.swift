import QRoute

public final class QRouteResolverMock: QRouteTestVerifier, QRouteResolving {

    public convenience init(clone source: QRouteResolverMock, route: QRoute? = nil) {
        self.init(route ?? source.route)
        self.routeTrail = source.routeTrail
        self.timesCalled = source.timesCalled
        self.valueFor = source.valueFor
    }

    public required init(_ route: QRoute) {
        self.route = route
    }

    public let route: QRoute

    public var input: Input = [:]

    public var onInput: QRouteResolving.OnInput = { _ in }

    public var routeTrail: [QRoute] = []

    public func newQRoutableMock(_ route: QRoute) -> QRoutableMock {
        return QRoutableMock(QRouteResolverMock(clone: self, route: route))
    }

    public func resolveRouteToChild(_ route: QRoute, from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion) {
        record("resolveRouteToChild()",
               ("route", route),
               ("from", from),
               ("input", input),
               ("animated", animated),
               ("completion", completion))
        routeTrail.append(route)
        completion(newQRoutableMock(route))
    }

    public func resolveRouteToParent(from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion) {
        record("resolveRouteToParent()",
               ("from", from),
               ("input", input),
               ("animated", animated),
               ("completion", completion))
        guard let parent = from.routeResolver.route.parent
            else { assertionFailure("Tried to navigate out of bounds"); return }
        routeTrail.append(parent)
        completion(newQRoutableMock(parent))
    }

    public func resolveRouteToSelf(from: QRoutable, input: Input, animated: Bool, completion: @escaping Completion) {
        record("resolveRouteToSelf()",
               ("from", from),
               ("input", input),
               ("animated", animated),
               ("completion", completion))
        routeTrail.append(from.routeResolver.route)
        completion(from)
    }
}
