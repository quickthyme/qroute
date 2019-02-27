
import UIKit

class RootInjector: NSObject {
    @IBOutlet weak var viewController: RootViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.route = AppRoute.plan
        viewController.routeResolver = RootRouteResolver()
        viewController.routeDriver = AppRoute.driver

        AppRoute.rootRoutable = viewController
    }
}
