
import XCTest

class MockRoutable: QTRoutable {
    var routeResolver: QTRouteResolving?

    init(routeResolver: QTRouteResolving?) {
        self.routeResolver = routeResolver
    }
}
