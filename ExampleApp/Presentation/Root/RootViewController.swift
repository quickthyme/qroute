
import UIKit

class RootViewController: UIViewController, QTRoutable {
    var route: QTRoute? = AppRoute.plan
    var routeResolver: QTRouteResolving? = RootRouteResolver()
    var routeDriver: QTRouteDriving? = AppRoute.driver

    var rootTabBarController: UITabBarController?

    override func viewDidLoad() {
        super.viewDidLoad()
        AppRoute.rootRoutable = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabController = segue.destination as? UITabBarController {
            self.rootTabBarController = tabController
        }
    }
}
