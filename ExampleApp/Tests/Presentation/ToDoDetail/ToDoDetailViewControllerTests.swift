
import XCTest

class ToDoDetailViewControllerTests: XCTestCase {

    var subject: ToDoDetailViewController!
    var mockRouteDriver: MockRouteDriver!

    override func setUp() {
        mockRouteDriver = MockRouteDriver()
        subject = (StoryboardLoader.loadViewController(from: "ToDoDetail") as! ToDoDetailViewController)
        subject.routeDriver = mockRouteDriver
    }

    func test_configuration_and_events() {
        given_view_controller_has_been_presented(subject) {
            with("route, routeResolver") {
                XCTAssertEqual(subject.route?.id, AppRoute.id.ToDoDetail)
                XCTAssert(subject.routeResolver is ToDoDetailRouteResolver)
            }
            when("contactUsNear action") {
                mockRouteDriver.reset()
                subject.contactUsNearAction(nil)
                then("it should drive (sub) to Contact Us") {
                    XCTAssertEqual(mockRouteDriver.timesCalled_driveSub, 1)
                    XCTAssertEqual(mockRouteDriver.valueFor_driveSub_targetId, AppRoute.id.ContactUs)
                }
            }
            when("contactUsFar action") {
                mockRouteDriver.reset()
                subject.contactUsFarAction(nil)
                then("it should drive all the way to Contact Us") {
                    XCTAssertEqual(mockRouteDriver.timesCalled_driveTo, 1)
                    XCTAssertEqual(mockRouteDriver.valueFor_driveTo_targetId, AppRoute.id.ContactUs)
                }
            }
        }
    }
}
