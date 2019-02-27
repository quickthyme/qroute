
import UIKit

class ContactUsViewController: UIViewController, QTRoutable {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.ContactUs)!
    var routeResolver: QTRouteResolving? = ContactUsRouteResolver()
    var routeDriver: QTRouteDriving? = AppRoute.driver

    @IBAction func dismissAction(_ sender: AnyObject?) {
        routeDriver?.driveParent(from: self, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
