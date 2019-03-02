
import XCTest
import QTRoute

class MessageCenterViewControllerTests: XCTestCase {

    var subject: MessageCenterViewController!
    var mockRouteDriver: MockQTRouteDriver!

    override func setUp() {
        mockRouteDriver = MockQTRouteDriver()
        subject = (StoryboardLoader.loadViewController(from: "MessageCenter") as! MessageCenterViewController)
        subject.routeDriver = mockRouteDriver
    }

    func test_configuration_and_events() {
        given_view_controller_has_been_presented(subject) {
            with("routeResolver") {
                XCTAssertEqual(subject.routeResolver?.route.id, AppRoute.id.MessageCenter)
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
