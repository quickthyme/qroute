
import UIKit

class ToDoDetailViewController: UIViewController {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.ToDoDetail)!
    var router: QTRouting? = AppRoute.rootRouter

    @IBAction func contactUsAction(_ sender: AnyObject) {
        router?.routeTo(AppRoute.id.ContactUs, from: self, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
