
import UIKit

class MainViewController: UIViewController {
    var route: QTRoute? = AppRoute.plan
    var router: QTRouting? = AppRoute.rootRouter
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
