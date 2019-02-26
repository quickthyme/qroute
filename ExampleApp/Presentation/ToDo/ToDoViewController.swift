
import UIKit

class ToDoViewController: UIViewController {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.ToDo)!
    var router: QTRouting? = AppRoute.rootRouter

    @IBAction func detailAction(_ sender: AnyObject) {
        router?.routeTo(AppRoute.id.ToDoDetail, from: self, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
