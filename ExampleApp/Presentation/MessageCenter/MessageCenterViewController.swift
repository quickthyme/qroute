
import UIKit
import QTRoute

class MessageCenterViewController: UIViewController, QTRoutable {
    var routeInput: QTRoutableInput?
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?

    @IBAction func playAction(_ sender: AnyObject?) {
        routeDriver?.driveSub(routeResolver!.route.id, from: self, input: nil,
                              animated: true,
                              completion: nil)
    }
}
