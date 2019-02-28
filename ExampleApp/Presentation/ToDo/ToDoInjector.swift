
import UIKit

class ToDoInjector: NSObject {
    @IBOutlet weak var viewController: ToDoViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = ToDoRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ToDo)!
        )
        viewController.routeDriver = AppRoute.driver
    }
}
