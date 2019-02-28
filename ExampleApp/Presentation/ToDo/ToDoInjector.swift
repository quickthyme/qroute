
import UIKit

class ToDoInjector: NSObject {
    @IBOutlet weak var viewController: ToDoViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ToDo)!,
            toChild: ToChildUIStoryboardNavigationControllerPushResolver(),
            toParent: ToParentAppRouteRootResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
