
import QRoute

public class MockQRoutable: QRoutable {
    public var routeResolver: QRouteResolving

    public init(_ routeResolver: QRouteResolving) {
        self.routeResolver = routeResolver
    }
}
