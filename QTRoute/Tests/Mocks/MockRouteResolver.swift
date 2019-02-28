
import XCTest

class MockRouteResolver: QTRouteResolving {

    let route: QTRoute

    required init(_ route: QTRoute) {
        self.route = route
    }

    convenience init(clone source: MockRouteResolver, route: QTRoute? = nil) {
        self.init(route ?? source.route)
        self.routeTrail = source.routeTrail
        self.timesCalled_resolveRouteToChild = source.timesCalled_resolveRouteToChild
        self.valueFor_resolveRouteToChild_input = source.valueFor_resolveRouteToChild_input
        self.timesCalled_resolveRouteToParent = source.timesCalled_resolveRouteToParent
        self.valueFor_resolveRouteToParent_input = source.valueFor_resolveRouteToParent_input
        self.timesCalled_resolveRouteToSelf = source.timesCalled_resolveRouteToSelf
        self.valueFor_resolveRouteToSelf_input = source.valueFor_resolveRouteToSelf_input
    }

    var routeTrail: [QTRoute] = []

    func newMockRoutable(_ route: QTRoute) -> MockRoutable {
        return MockRoutable(routeResolver: MockRouteResolver(clone: self, route: route))
    }

    var timesCalled_resolveRouteToChild: Int = 0
    var valueFor_resolveRouteToChild_input: QTRoutableInput = [:]
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToChild += 1
        valueFor_resolveRouteToChild_input = input
        routeTrail.append(route)
        completion(newMockRoutable(route))
    }

    var timesCalled_resolveRouteToParent: Int = 0
    var valueFor_resolveRouteToParent_input: QTRoutableInput = [:]
    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToParent += 1
        valueFor_resolveRouteToParent_input = input
        guard let parent = from.routeResolver?.route.parent else { XCTFail("Tried to navigate out of bounds"); return }
        routeTrail.append(parent)
        completion(newMockRoutable(parent))
    }

    var timesCalled_resolveRouteToSelf: Int = 0
    var valueFor_resolveRouteToSelf_input: QTRoutableInput = [:]
    func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToSelf += 1
        valueFor_resolveRouteToSelf_input = input
        routeTrail.append(from.routeResolver!.route)
        completion(from)
    }
}
