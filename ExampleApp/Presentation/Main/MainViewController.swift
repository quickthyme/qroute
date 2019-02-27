
import UIKit

class MainViewController: UIViewController, QTRoutable {
    var route: QTRoute? = AppRoute.plan
    var routeResolver: QTRouteResolving? = MainRouteResolver()
    var routeDriver: QTRouteDriving? = AppRoute.driver

    var mainTabBarController: UITabBarController?

    override func viewDidLoad() {
        super.viewDidLoad()
        AppRoute.rootRoutable = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabController = segue.destination as? UITabBarController {
            self.mainTabBarController = tabController
        }
    }
}
