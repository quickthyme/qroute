
import UIKit

class HelpInjector: NSObject {
    @IBOutlet weak var viewController: HelpViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.Help)!,
            toChild: HelpToChildResolver(),
            toParent: ToParentAppRouteRootResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
