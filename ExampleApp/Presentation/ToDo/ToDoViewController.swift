
import UIKit

class ToDoViewController: UIViewController, QTRoutable {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.ToDo)!
    var routeResolver: QTRouteResolving? = ToDoRouteResolver()
    var routeDriver: QTRouteDriving? = AppRoute.driver

    @IBAction func detailAction(_ sender: AnyObject) {
        routeDriver?.driveTo(AppRoute.id.ToDoDetail, from: self, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
