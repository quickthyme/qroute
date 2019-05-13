import QRoute

public class QRoutableMock: QRoutable {
    public var routeResolver: QRouteResolving!

    public init(_ routeResolver: QRouteResolving) {
        self.routeResolver = routeResolver
    }
}
