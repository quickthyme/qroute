
import QRoute

public final class MockQRouteResolver: QRouteResolving {

    public let route: QRoute

    public required init(_ route: QRoute) {
        self.route = route
    }

    public convenience init(clone source: MockQRouteResolver, route: QRoute? = nil) {
        self.init(route ?? source.route)
        self.routeTrail = source.routeTrail
        self.timesCalled_resolveRouteToChild = source.timesCalled_resolveRouteToChild
        self.valueFor_resolveRouteToChild_input = source.valueFor_resolveRouteToChild_input
        self.timesCalled_resolveRouteToParent = source.timesCalled_resolveRouteToParent
        self.valueFor_resolveRouteToParent_input = source.valueFor_resolveRouteToParent_input
        self.timesCalled_resolveRouteToSelf = source.timesCalled_resolveRouteToSelf
        self.valueFor_resolveRouteToSelf_input = source.valueFor_resolveRouteToSelf_input
    }

    public var routeTrail: [QRoute] = []

    public func newMockQRoutable(_ route: QRoute) -> MockQRoutable {
        return MockQRoutable(MockQRouteResolver(clone: self, route: route))
    }

    public var timesCalled_resolveRouteToChild: Int = 0
    public var valueFor_resolveRouteToChild_input: QRoutableInput = [:]
    public func resolveRouteToChild(_ route: QRoute, from: QRoutable, input: QRoutableInput, animated: Bool, completion: @escaping QRoutableCompletion) {
        timesCalled_resolveRouteToChild += 1
        valueFor_resolveRouteToChild_input = input
        routeTrail.append(route)
        completion(newMockQRoutable(route))
    }

    public var timesCalled_resolveRouteToParent: Int = 0
    public var valueFor_resolveRouteToParent_input: QRoutableInput = [:]
    public func resolveRouteToParent(from: QRoutable, input: QRoutableInput, animated: Bool, completion: @escaping QRoutableCompletion) {
        timesCalled_resolveRouteToParent += 1
        valueFor_resolveRouteToParent_input = input
        guard let parent = from.routeResolver?.route.parent
            else { assertionFailure("Tried to navigate out of bounds"); return }
        routeTrail.append(parent)
        completion(newMockQRoutable(parent))
    }

    public var timesCalled_resolveRouteToSelf: Int = 0
    public var valueFor_resolveRouteToSelf_input: QRoutableInput = [:]
    public func resolveRouteToSelf(from: QRoutable, input: QRoutableInput, animated: Bool, completion: @escaping QRoutableCompletion) {
        timesCalled_resolveRouteToSelf += 1
        valueFor_resolveRouteToSelf_input = input
        routeTrail.append(from.routeResolver!.route)
        completion(from)
    }
}