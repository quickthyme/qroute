
import UIKit

class ToDoViewController: UIViewController, QTRoutable {
    var route: QTRoute?
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    @IBAction func detailAction(_ sender: AnyObject?) {
        routeDriver?.driveTo(AppRoute.id.ToDoDetail, from: self, completion: nil)
    }
}
