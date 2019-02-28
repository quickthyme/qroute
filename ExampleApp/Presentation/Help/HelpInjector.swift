
import UIKit

class HelpInjector: NSObject {
    @IBOutlet weak var viewController: HelpViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.route = AppRoute.plan.findDescendant(AppRoute.id.Help)!
        viewController.routeResolver = HelpRouteResolver()
        viewController.routeDriver = AppRoute.driver
    }
}