
import UIKit

class ToDoDetailInjector: NSObject {
    @IBOutlet weak var viewController: ToDoDetailViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.route = AppRoute.plan.findDescendent(AppRoute.id.ToDoDetail)!
        viewController.routeResolver = ToDoDetailRouteResolver()
        viewController.routeDriver = AppRoute.driver
    }
}
