
import UIKit
import XCTest

extension XCTest {

    @discardableResult
    func given_view_controller_has_been_presented<Result>(_ viewController: UIViewController, block: () throws -> Result) rethrows -> Result {
        return try XCTContext.runActivity(named: "GIVEN viewControlller (\(type(of: viewController))) has been presented") { _ in
            XCTAssertNotNil(viewController.view)
            viewController.viewWillAppear(false)
            viewController.viewDidAppear(false)
            return try block()
        }
    }
}
