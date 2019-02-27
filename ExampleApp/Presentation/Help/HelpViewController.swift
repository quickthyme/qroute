
import UIKit

class HelpViewController: UIViewController, QTRoutable {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.Help)!
    var routeResolver: QTRouteResolving? = HelpRouteResolver()
    var routeDriver: QTRouteDriving? = AppRoute.driver
    var segueRouteCompletion: QTRoutableCompletion? = nil

    @IBAction func messageCenterAction(_ sender: AnyObject?) {
        routeDriver?.driveTo(AppRoute.id.MessageCenter, from: self, completion: nil)
    }

    @IBAction func contactUsAction(_ sender: AnyObject?) {
        routeDriver?.driveTo(AppRoute.id.ContactUs, from: self, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? QTRoutable {
            segueRouteCompletion?(target)
        }
    }
}
