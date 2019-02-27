
import UIKit

class ToDoInjector: NSObject {
    @IBOutlet weak var viewController: ToDoViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.route = AppRoute.plan.findDescendent(AppRoute.id.ToDo)!
        viewController.routeResolver = ToDoRouteResolver()
        viewController.routeDriver = AppRoute.driver
    }
}
