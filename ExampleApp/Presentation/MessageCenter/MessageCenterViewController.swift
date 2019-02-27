
import UIKit

class MessageCenterViewController: UIViewController, QTRoutable {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.MessageCenter)!
    var routeResolver: QTRouteResolving? = MessageCenterRouteResolver()
    var routeDriver: QTRouteDriving? = AppRoute.driver

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
