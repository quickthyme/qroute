
import UIKit

class HelpViewController: UIViewController, QTRoutable {
    var route: QTRoute?
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?
    var segueRouteCompletion: QTRoutableCompletion?

    @IBAction func messageCenterAction(_ sender: AnyObject?) {
        routeDriver?.driveTo(AppRoute.id.MessageCenter, from: self, input: nil, completion: nil)
    }

    @IBAction func contactUsAction(_ sender: AnyObject?) {
        routeDriver?.driveTo(AppRoute.id.ContactUs, from: self, input: nil, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? QTRoutable {
            segueRouteCompletion?(target)
        }
    }
}
