
import UIKit

class MessageCenterInjector: NSObject {
    @IBOutlet weak var viewController: MessageCenterViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.MessageCenter)!,
            resolveRouteToChild: ToChildUIStoryboardNavigationControllerPushResolver(),
            resolveRouteToParent: ToParentNavigationControllerPopResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
