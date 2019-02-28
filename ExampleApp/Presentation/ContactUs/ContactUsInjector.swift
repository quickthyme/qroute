
import UIKit

class ContactUsInjector: NSObject {
    @IBOutlet weak var viewController: ContactUsViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ContactUs)!,
            toChild: ToChildNoOpResolver(),
            toParent: ToParentDismissModalResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
