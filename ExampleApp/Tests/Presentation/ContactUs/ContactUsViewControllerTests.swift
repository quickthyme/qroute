
import XCTest
import QTRoute

class ContactUsViewControllerTests: XCTestCase {

    var subject: ContactUsViewController!
    var mockRouteDriver: MockQTRouteDriver!

    override func setUp() {
        mockRouteDriver = MockQTRouteDriver()
        subject = (StoryboardLoader.loadViewController(from: "ContactUs") as! ContactUsViewController)
        subject.routeDriver = mockRouteDriver
    }

    func test_configuration_and_events() {
        given_view_controller_has_been_presented(subject) {
            with("routeResolver") {
                XCTAssertEqual(subject.routeResolver?.route.id, AppRoute.id.ContactUs)
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
