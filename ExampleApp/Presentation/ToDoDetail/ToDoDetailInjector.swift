
import UIKit

class ToDoDetailInjector: NSObject {
    @IBOutlet weak var viewController: ToDoDetailViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = ToDoDetailRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ToDoDetail)!
        )
        viewController.routeDriver = AppRoute.driver
    }
}
