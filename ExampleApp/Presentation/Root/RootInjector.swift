
import UIKit

class RootInjector: NSObject {
    @IBOutlet weak var viewController: RootViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = RootRouteResolver(AppRoute.plan)
        viewController.routeDriver = AppRoute.driver

        AppRoute.rootRoutable = viewController
    }
}
