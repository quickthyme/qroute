
import QRoute

public class MockQRoutable: QRoutable {
    public var routeInput: QRoutableInput?
    public var routeResolver: QRouteResolving?

    public init(_ routeResolver: QRouteResolving?) {
        self.routeResolver = routeResolver
    }
}
