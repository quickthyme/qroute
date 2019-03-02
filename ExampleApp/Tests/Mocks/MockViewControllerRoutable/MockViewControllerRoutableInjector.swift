
import UIKit
import QTRoute

class MockViewControllerRoutableInjector: NSObject {
    @IBOutlet weak var viewController: MockViewControllerRoutable!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = MockQTRouteResolver(
            QTRoute("MockViewControllerRoutable")
        )
    }
}
