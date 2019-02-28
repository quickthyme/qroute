
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
            with("routeResolver") {
                XCTAssertEqual(subject.routeResolver?.route.id, AppRoute.id.ToDo)
            }
            when("making selection") {
                mockRouteDriver.reset()
                subject.toDoTableViewManager(ToDoTableViewManager(), didSelectId: 36)
                then("it should drive to ToDoDetail with toDoId input") {
                    XCTAssertEqual(mockRouteDriver.timesCalled_driveTo, 1)
                    XCTAssertEqual(mockRouteDriver.valueFor_driveTo_targetId, AppRoute.id.ToDoDetail)
                    XCTAssertEqual(mockRouteDriver.valueFor_driveTo_input?["toDoId"] as? Int, 36)
                }
            }
        }
    }
}
