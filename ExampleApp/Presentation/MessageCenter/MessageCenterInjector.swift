
import UIKit

class MessageCenterInjector: NSObject {
    @IBOutlet weak var viewController: MessageCenterViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.route = AppRoute.plan.findDescendant(AppRoute.id.MessageCenter)!
        viewController.routeResolver = MessageCenterRouteResolver()
        viewController.routeDriver = AppRoute.driver
    }
}
