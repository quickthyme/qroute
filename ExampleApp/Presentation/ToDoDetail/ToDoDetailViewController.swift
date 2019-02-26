
import UIKit

class ToDoDetailViewController: UIViewController {
    var route: QTRoute = AppRoute.plan.findDescendent(AppRoute.id.ToDoDetail)!
    var router: QTRouting? = AppRoute.rootRouter

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
