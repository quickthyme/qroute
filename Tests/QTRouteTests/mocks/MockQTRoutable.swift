
import QTRoute

public class MockQTRoutable: QTRoutable {
    public var routeInput: QTRoutableInput?
    public var routeResolver: QTRouteResolving?

    public init(_ routeResolver: QTRouteResolving?) {
        self.routeResolver = routeResolver
    }
}
