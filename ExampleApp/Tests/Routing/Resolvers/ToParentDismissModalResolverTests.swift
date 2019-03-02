
import XCTest
import UIKit
import QTRoute

class ToParentDismissModalResolverTests: XCTestCase {

    let subject: QTRouteResolver.ActionType.ToParent = ToParentDismissModalResolver()

    func test_resolve() {

        given("routable is being presented") {
            let presentedRoute = QTRoute("presented")
            let presenterRoute = QTRoute("presenter", presentedRoute)
            let presented = MockViewControllerRoutable(presentedRoute)
            let presenter = MockViewControllerRoutable(presenterRoute)

            presenter.present(presented, animated: false)

            when("it is executed") {
                let (captured, completion) = captureRoutableCompletion()
                subject(presented, [:], false, completion)

                then("the presenter routable should dismiss the presented") {
                    XCTAssertTrue(presenter.wasCalled_dismiss)
                }
                with("matching last resolved routable") {
                    XCTAssert(captured.value === presenter)
                }
            }
        }
    }
}
