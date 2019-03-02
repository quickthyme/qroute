
import XCTest
import UIKit
import QTRoute

class ToParentNavigationControllerPopResolverTests: XCTestCase {

    let subject: QTRouteResolver.ActionType.ToParent = ToParentNavigationControllerPopResolver()

    func test_resolve() {

        given("parent child routables in a navigation controller") {
            let childRoute = QTRoute("presented")
            let parentRoute = QTRoute("presenter", childRoute)
            let child = MockViewControllerRoutable(childRoute)
            let parent = MockViewControllerRoutable(parentRoute).inMockNavigationController
            let mockNavigationController = parent.mockNavigationController!
            mockNavigationController.pushViewController(child, animated: false)

            when("it is executed") {
                let (captured, completion) = captureRoutableCompletion()
                subject(child, [:], false, completion)

                then("the navigation controller should pop back to the parent") {
                    XCTAssertEqual(mockNavigationController.topViewController, parent)
                }
                with("last resolved routable match") {
                    XCTAssert(captured.value === parent)
                }
            }
        }
    }
}
