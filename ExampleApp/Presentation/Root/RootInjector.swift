
import UIKit

class RootInjector: NSObject {
    @IBOutlet weak var viewController: RootViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan,
            toChild: RootToChildResolver(),
            toParent: RootToParentResolver()
        )
        viewController.routeDriver = AppRoute.driver

        AppRoute.rootRoutable = viewController
    }
}
