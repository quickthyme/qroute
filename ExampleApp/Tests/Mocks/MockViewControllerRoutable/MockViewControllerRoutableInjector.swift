
import UIKit

class MockViewControllerRoutableInjector: NSObject {
    @IBOutlet weak var viewController: MockViewControllerRoutable!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = MockRouteResolver(
            QTRoute("MockViewControllerRoutable")
        )
    }
}
