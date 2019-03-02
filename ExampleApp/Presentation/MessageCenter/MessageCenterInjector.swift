
import UIKit
import QTRoute

class MessageCenterInjector: NSObject {
    @IBOutlet weak var viewController: MessageCenterViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.MessageCenter)!,
            toChild: ToChildUIStoryboardNavigationControllerPushResolver(),
            toParent: ToParentNavigationControllerPopResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
