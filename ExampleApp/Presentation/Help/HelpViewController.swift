
import UIKit

class HelpViewController: UIViewController {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.Help)!
    var router: QTRouting? = AppRoute.rootRouter
    var segueRouteCompletion: QTRoutableCompletion? = nil

    @IBAction func messageCenterAction(_ sender: AnyObject) {
        router?.routeTo(AppRoute.id.MessageCenter, from: self, completion: nil)
    }

    @IBAction func contactUsAction(_ sender: AnyObject) {
        router?.routeTo(AppRoute.id.ContactUs, from: self, completion: nil)
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
