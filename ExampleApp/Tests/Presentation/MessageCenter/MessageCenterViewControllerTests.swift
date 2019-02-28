
import XCTest

class MessageCenterViewControllerTests: XCTestCase {

    var subject: MessageCenterViewController!
    var mockRouteDriver: MockRouteDriver!

    override func setUp() {
        mockRouteDriver = MockRouteDriver()
        subject = (StoryboardLoader.loadViewController(from: "MessageCenter") as! MessageCenterViewController)
        subject.routeDriver = mockRouteDriver
    }

    func test_configuration_and_events() {
        given_view_controller_has_been_presented(subject) {
            with("route, routeResolver") {
                XCTAssertEqual(subject.route?.id, AppRoute.id.MessageCenter)
                XCTAssert(subject.routeResolver is MessageCenterRouteResolver)
            }

            when("play action") {
                mockRouteDriver.reset()
                subject.playAction(nil)
                then("it should drive (sub) to `self`") {
                    XCTAssertEqual(mockRouteDriver.timesCalled_driveSub, 1)
                    XCTAssertEqual(mockRouteDriver.valueFor_driveSub_targetId, AppRoute.id.MessageCenter)
                }
            }
        }
    }
}
