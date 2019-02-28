
import UIKit

class ToDoDetailInjector: NSObject {
    @IBOutlet weak var viewController: ToDoDetailViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ToDoDetail)!,
            resolveRouteToChild: ToChildUIStoryboardPresentModalResolver(),
            resolveRouteToParent: ToParentNavigationControllerPopResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
