
import UIKit

class ToDoDetailViewController: UIViewController, QTRoutable {
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    var routeInput: QTRoutableInput? {
        didSet {
            self.navigationItem.title = "Item \(routeInput?["toDoId"] as? Int ?? -1)"
        }
    }

    @IBAction func contactUsNearAction(_ sender: AnyObject?) {
        routeDriver?.driveSub(AppRoute.id.ContactUs, from: self, input: nil, completion: nil)
    }

    @IBAction func contactUsFarAction(_ sender: AnyObject?) {
        routeDriver?.driveTo(AppRoute.id.ContactUs, from: self, input: nil, completion: nil)
    }
}
