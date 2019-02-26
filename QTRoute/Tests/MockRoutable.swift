
import XCTest

class MockRoutable: QTRoutable {
    var route: QTRoute?
    var router: QTRouting? = nil
    var routeTrail: [QTRoute] = []

    init(route:QTRoute) {
        self.route = route
    }

    var timesCalled_routeToChild: Int = 0
    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion) {
        timesCalled_routeToChild += 1
        routeTrail.append(route)
        self.route = route
        completion(self)
    }

    var timesCalled_routeToParent: Int = 0
    func routeToParent(completion: @escaping QTRoutableCompletion) {
        timesCalled_routeToParent += 1
        guard let parent = self.route!.parent else { XCTFail("Tried to navigate out of bounds"); return }
        routeTrail.append(parent)
        self.route = parent
        completion(self)
    }

    var timesCalled_routeToSelf: Int = 0
    func routeToSelf(completion: @escaping QTRoutableCompletion) {
        timesCalled_routeToSelf += 1
        routeTrail.append(self.route!)
        completion(self)
    }
}
