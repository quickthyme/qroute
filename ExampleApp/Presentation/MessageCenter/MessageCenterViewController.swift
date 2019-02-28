
import UIKit

class MessageCenterViewController: UIViewController, QTRoutable {
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    @IBAction func playAction(_ sender: AnyObject?) {
        routeDriver?.driveSub(routeResolver!.route.id, from: self, input: nil, completion: nil)
    }
}
