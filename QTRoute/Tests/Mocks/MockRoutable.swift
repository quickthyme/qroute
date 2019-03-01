
import XCTest

class MockRoutable: QTRoutable {
    var routeInput: QTRoutableInput?
    var routeResolver: QTRouteResolving?

    init(_ routeResolver: QTRouteResolving?) {
        self.routeResolver = routeResolver
    }
}
