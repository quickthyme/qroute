
import XCTest

class ToDoViewControllerTests: XCTestCase {

    var subject: ToDoViewController!
    var mockRouteDriver: MockRouteDriver!

    override func setUp() {
        mockRouteDriver = MockRouteDriver()
        subject = (StoryboardLoader.loadViewController(from: "ToDo") as! ToDoViewController)
        subject.routeDriver = mockRouteDriver
    }

    func test_configuration_and_events() {
        given_view_controller_has_been_presented(subject) {
            with("route, routeResolver") {
                XCTAssertEqual(subject.route?.id, AppRoute.id.ToDo)
                XCTAssert(subject.routeResolver is ToDoRouteResolver)
            }
            when("detail action") {
                mockRouteDriver.reset()
                subject.detailAction(nil)
                then("it should drive to ToDoDetail") {
                    XCTAssertEqual(mockRouteDriver.timesCalled_driveTo, 1)
                    XCTAssertEqual(mockRouteDriver.valueFor_driveTo_targetId, AppRoute.id.ToDoDetail)
                }
            }
        }
    }
}
