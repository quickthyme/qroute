
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
            with("routeResolver") {
                XCTAssertEqual(subject.routeResolver?.route.id, AppRoute.id.Root)
            }
            with("rootTabBarController") {
                XCTAssertNotNil(subject.rootTabBarController)
            }
        }
    }
}
