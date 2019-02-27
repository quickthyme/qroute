
import XCTest

class AppRouteTests: XCTestCase {
    func test_routesAreAllUnique() {
        given("App Route Plan") {
            let routePlan = AppRoute.plan
            then("all route ids are unique") {
                let expectedNumberOfRoutes = 6
                XCTAssertEqual(routePlan.flattened.count, expectedNumberOfRoutes)
            }
        }
    }
}
