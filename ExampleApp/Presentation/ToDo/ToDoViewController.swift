
import UIKit

class ToDoViewController: UIViewController, QTRoutable {
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    @IBAction func detailAction(_ sender: AnyObject?) {
        let id = sender?.tag ?? 0
        routeDriver?.driveTo(AppRoute.id.ToDoDetail, from: self, input: ["todoId": "\(id)"], completion: nil)
    }
}
