
import UIKit

class ToDoDetailViewController: UIViewController, QTRoutable {
    var route: QTRoute?
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    @IBAction func contactUsNearAction(_ sender: AnyObject?) {
        routeDriver?.driveSub(AppRoute.id.ContactUs, from: self, completion: nil)
    }

    @IBAction func contactUsFarAction(_ sender: AnyObject?) {
        routeDriver?.driveTo(AppRoute.id.ContactUs, from: self, completion: nil)
    }
}
