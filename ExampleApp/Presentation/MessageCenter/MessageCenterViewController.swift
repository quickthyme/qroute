
import UIKit

class MessageCenterViewController: UIViewController, QTRoutable {
    var route: QTRoute?
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    @IBAction func playAction(_ sender: AnyObject?) {
        routeDriver?.driveSub(route!.id, from: self, input: nil, completion: nil)
    }
}
