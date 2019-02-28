
import UIKit

class MessageCenterInjector: NSObject {
    @IBOutlet weak var viewController: MessageCenterViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = MessageCenterRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.MessageCenter)!
        )
        viewController.routeDriver = AppRoute.driver
    }
}
