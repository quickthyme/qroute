
import XCTest

class MockRoutable: QTRoutable {
    var routeInput: QTRoutableInput?
    var routeResolver: QTRouteResolving?

    init(routeResolver: QTRouteResolving?) {
        self.routeResolver = routeResolver
    }
}
