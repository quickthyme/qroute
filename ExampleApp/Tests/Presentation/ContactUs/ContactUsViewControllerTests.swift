
import XCTest

class ContactUsViewControllerTests: XCTestCase {

    var subject: ContactUsViewController!
    var mockRouteDriver: MockRouteDriver!

    override func setUp() {
        mockRouteDriver = MockRouteDriver()
        subject = (StoryboardLoader.loadViewController(from: "ContactUs") as! ContactUsViewController)
        subject.routeDriver = mockRouteDriver
    }

    func test_configuration_and_events() {
        given_view_controller_has_been_presented(subject) {
            with("route, routeResolver") {
                XCTAssertEqual(subject.route?.id, AppRoute.id.ContactUs)
                XCTAssert(subject.routeResolver is ContactUsRouteResolver)
            }
            when("dismissAction") {
                subject.dismissAction(nil)
                then("it should drive to parent") {
                    XCTAssertEqual(mockRouteDriver.timesCalled_driveParent, 1)
                }
            }
        }
    }
}