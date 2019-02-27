
import XCTest

class MockRouteResolver: QTRouteResolving {

    var routeTrail: [QTRoute] = []

    func newMockRoutable(_ route: QTRoute) -> MockRoutable {
        return MockRoutable(route: route, routeResolver: self)
    }

    var timesCalled_resolveRouteToChild: Int = 0
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToChild += 1
        routeTrail.append(route)
        completion(newMockRoutable(route))
    }

    var timesCalled_resolveRouteToParent: Int = 0
    func resolveRouteToParent(from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToParent += 1
        guard let parent = from.route!.parent else { XCTFail("Tried to navigate out of bounds"); return }
        routeTrail.append(parent)
        completion(newMockRoutable(parent))
    }

    var timesCalled_resolveRouteToSelf: Int = 0
    func resolveRouteToSelf(from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToSelf += 1
        routeTrail.append(from.route!)
        completion(from)
    }
}
