
import XCTest
import UIKit

class ToParentDismissModalResolverTests: XCTestCase {

    let subject: QTRouteResolver.ToParent = ToParentDismissModalResolver()
    let inputStream: QTRoutableInput = [
        "somethingForSusan":"123.45.678.910.11.12",
        "somethingForBruce":[1,-1]
    ]

    func test_resolve() {

        given("routable is being presented") {
            let presentedRoute = QTRoute("presented")
            let presenterRoute = QTRoute("presenter", presentedRoute)
            let presented = MockViewControllerRoutable(presentedRoute)
            let presenter = MockViewControllerRoutable(presenterRoute)

            presenter.present(presented, animated: false)

            when("it is executed") {
                let (captured, completion) = captureRoutableCompletion()
                subject(presented, inputStream, false, completion)

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
