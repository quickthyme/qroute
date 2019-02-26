
import UIKit

class ContactUsViewController: UIViewController {
    var route: QTRoute? = AppRoute.plan.findDescendent(AppRoute.id.ContactUs)!
    var router: QTRouting? = AppRoute.rootRouter

    @IBAction func dismissAction(_ sender: AnyObject?) {
        guard let parent = self.route?.parent else { return }
        router?.routeTo(parent.id, from: self, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
