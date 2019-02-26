
import UIKit

class ToDoViewController: UIViewController {
    var route: QTRoute = AppRoute.plan.findDescendent(AppRoute.id.ToDo)!
    var router: QTRouting? = AppRoute.rootRouter

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
