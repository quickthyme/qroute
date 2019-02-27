
import UIKit

class ContactUsViewController: UIViewController, QTRoutable {
    var route: QTRoute?
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    @IBAction func dismissAction(_ sender: AnyObject?) {
        routeDriver?.driveParent(from: self, completion: nil)
    }
}
