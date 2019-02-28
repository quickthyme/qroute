
import UIKit

class RootViewController: UIViewController, QTRoutable {
    var routeInput: QTRoutableInput?
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    var rootTabBarController: UITabBarController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabController = segue.destination as? UITabBarController {
            self.rootTabBarController = tabController
        }
    }
}
