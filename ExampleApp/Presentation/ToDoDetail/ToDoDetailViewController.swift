
import UIKit

class ToDoDetailViewController: UIViewController {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.ToDoDetail)!
    var router: QTRouting? = AppRoute.rootRouter

    @IBAction func contactUsAction(_ sender: AnyObject) {
        router?.routeSub(AppRoute.id.ContactUs, from: self, completion: nil)
    }

    @IBAction func messageCenterAction(_ sender: AnyObject) {
        router?.routeTo(AppRoute.id.MessageCenter, from: self, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
