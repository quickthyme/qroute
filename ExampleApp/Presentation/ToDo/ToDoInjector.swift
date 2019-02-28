
import UIKit

class ToDoInjector: NSObject {
    @IBOutlet weak var viewController: ToDoViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ToDo)!,
            resolveRouteToChild: ToChildUIStoryboardNavigationControllerPushResolver(),
            resolveRouteToParent: ToParentAppRouteRootResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
