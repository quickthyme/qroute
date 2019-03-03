
import QTRoute

public final class MockQTRouteResolver: QTRouteResolving {

    public let route: QTRoute

    public required init(_ route: QTRoute) {
        self.route = route
    }

    public convenience init(clone source: MockQTRouteResolver, route: QTRoute? = nil) {
        self.init(route ?? source.route)
        self.routeTrail = source.routeTrail
        self.timesCalled_resolveRouteToChild = source.timesCalled_resolveRouteToChild
        self.valueFor_resolveRouteToChild_input = source.valueFor_resolveRouteToChild_input
        self.timesCalled_resolveRouteToParent = source.timesCalled_resolveRouteToParent
        self.valueFor_resolveRouteToParent_input = source.valueFor_resolveRouteToParent_input
        self.timesCalled_resolveRouteToSelf = source.timesCalled_resolveRouteToSelf
        self.valueFor_resolveRouteToSelf_input = source.valueFor_resolveRouteToSelf_input
    }

    public var routeTrail: [QTRoute] = []

    public func newMockQTRoutable(_ route: QTRoute) -> MockQTRoutable {
        return MockQTRoutable(MockQTRouteResolver(clone: self, route: route))
    }

    public var timesCalled_resolveRouteToChild: Int = 0
    public var valueFor_resolveRouteToChild_input: QTRoutableInput = [:]
    public func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToChild += 1
        valueFor_resolveRouteToChild_input = input
        routeTrail.append(route)
        completion(newMockQTRoutable(route))
    }

    public var timesCalled_resolveRouteToParent: Int = 0
    public var valueFor_resolveRouteToParent_input: QTRoutableInput = [:]
    public func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToParent += 1
        valueFor_resolveRouteToParent_input = input
        guard let parent = from.routeResolver?.route.parent
            else { assertionFailure("Tried to navigate out of bounds"); return }
        routeTrail.append(parent)
        completion(newMockQTRoutable(parent))
    }

    public var timesCalled_resolveRouteToSelf: Int = 0
    public var valueFor_resolveRouteToSelf_input: QTRoutableInput = [:]
    public func resolveRouteToSelf(from: QTRoutable, input: QTRoutableInput, animated: Bool, completion: @escaping QTRoutableCompletion) {
        timesCalled_resolveRouteToSelf += 1
        valueFor_resolveRouteToSelf_input = input
        routeTrail.append(from.routeResolver!.route)
        completion(from)
    }
}
