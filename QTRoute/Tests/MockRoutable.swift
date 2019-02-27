
import XCTest

class MockRoutable: QTRoutable {
    var route: QTRoute?
    var routeResolver: QTRouteResolving?

    init(route: QTRoute?, routeResolver: QTRouteResolving?) {
        self.route = route
        self.routeResolver = routeResolver
    }
}
