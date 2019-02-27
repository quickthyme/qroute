
import XCTest

class MockRouteResolver: QTRouteResolving {

    var routeTrail: [QTRoute] = []

    func newMockRoutable(_ route: QTRoute) -> MockRoutable {
        return MockRoutable(route: route, routeResolver: self)
    }

    var timesCalled_resolveRouteToChild: Int = 0
    var valueFor_resolveRouteToChild_input: QTRouteResolvingInput = [:]
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToChild += 1
        valueFor_resolveRouteToChild_input = input
        routeTrail.append(route)
        completion(newMockRoutable(route))
    }

    var timesCalled_resolveRouteToParent: Int = 0
    var valueFor_resolveRouteToParent_input: QTRouteResolvingInput = [:]
    func resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToParent += 1
        valueFor_resolveRouteToParent_input = input
        guard let parent = from.route!.parent else { XCTFail("Tried to navigate out of bounds"); return }
        routeTrail.append(parent)
        completion(newMockRoutable(parent))
    }

    var timesCalled_resolveRouteToSelf: Int = 0
    var valueFor_resolveRouteToSelf_input: QTRouteResolvingInput = [:]
    func resolveRouteToSelf(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToSelf += 1
        valueFor_resolveRouteToSelf_input = input
        routeTrail.append(from.route!)
        completion(from)
    }
}
