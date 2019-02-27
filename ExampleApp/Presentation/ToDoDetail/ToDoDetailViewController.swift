
import UIKit

class ToDoDetailViewController: UIViewController, QTRoutable {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.ToDoDetail)!
    var routeResolver: QTRouteResolving? = ToDoDetailRouteResolver()
    var routeDriver: QTRouteDriving? = AppRoute.driver

    @IBAction func contactUsNearAction(_ sender: AnyObject) {
        routeDriver?.driveSub(AppRoute.id.ContactUs, from: self, completion: nil)
    }

    @IBAction func contactUsFarAction(_ sender: AnyObject) {
        routeDriver?.driveTo(AppRoute.id.ContactUs, from: self, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
