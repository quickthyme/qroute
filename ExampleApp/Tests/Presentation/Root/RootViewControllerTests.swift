
import XCTest

class RootViewControllerTests: XCTestCase {

    var subject: RootViewController!
    var mockRouteDriver: MockRouteDriver!

    override func setUp() {
        mockRouteDriver = MockRouteDriver()
        subject = (StoryboardLoader.loadViewController(from: "Root") as! RootViewController)
        subject.routeDriver = mockRouteDriver
    }

    func test_configuration_and_events() {
        given_view_controller_has_been_presented(subject) {
            with("route, routeResolver") {
                XCTAssertEqual(subject.route?.id, AppRoute.id.Root)
                XCTAssert(subject.routeResolver is RootRouteResolver)
            }
            with("rootTabBarController") {
                XCTAssertNotNil(subject.rootTabBarController)
            }
        }
    }
}
