
import UIKit

class HelpInjector: NSObject {
    @IBOutlet weak var viewController: HelpViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = HelpRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.Help)!
        )
        viewController.routeDriver = AppRoute.driver
    }
}
