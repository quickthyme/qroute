
import UIKit

class RootInjector: NSObject {
    @IBOutlet weak var viewController: RootViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan,
            resolveRouteToChild: RootToChildResolver(),
            resolveRouteToParent: RootToParentResolver()
        )
        viewController.routeDriver = AppRoute.driver

        AppRoute.rootRoutable = viewController
    }
}
