
import UIKit

class ContactUsViewController: UIViewController {
    var route: QTRoute = AppRoute.plan.findDescendent(AppRoute.id.ContactUs)!
    var router: QTRouting? = AppRoute.rootRouter

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
