
import XCTest
import UIKit

class ToChildUIStoryboardPresentModalResolverTests: XCTestCase {

    let subject: QTRouteResolver.ToChild = ToChildUIStoryboardPresentModalResolver()
    let inputStream: QTRoutableInput = [
        "somethingForSusan":"123.45.678.910.11.12",
        "somethingForBruce":[1,-1]
    ]

    func test_resolve() {

        given("source, target, inputStream, animated, completion") {
            let target = QTRoute("MockViewControllerRoutable")
            let mockRoutable = MockViewControllerRoutable(QTRoute("source", target))
                .embeddedInWindow

            when("executed") {
                let (captured, completion) = captureRoutableCompletion()
                subject(target, mockRoutable, inputStream, false, completion)

                then("it should have presented a view controller") {
                    XCTAssertTrue(mockRoutable.wasCalled_present)
                    XCTAssertNotNil(mockRoutable.presentedViewController)
                }

                then("it should have called the completion handler with correct routable") {
                    XCTAssertEqual(captured.value?.routeResolver?.route, target)
                }
            }
        }
    }
}
