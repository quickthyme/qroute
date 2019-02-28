
import UIKit

class ContactUsInjector: NSObject {
    @IBOutlet weak var viewController: ContactUsViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ContactUs)!,
            resolveRouteToChild: ToChildNoOpResolver(),
            resolveRouteToParent: ToParentDismissModalResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
