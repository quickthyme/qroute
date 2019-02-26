
import UIKit

class MessageCenterViewController: UIViewController {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.MessageCenter)!
    var router: QTRouting? = AppRoute.rootRouter

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
