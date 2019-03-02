
import UIKit
import QTRoute

class ContactUsInjector: NSObject {
    @IBOutlet weak var viewController: ContactUsViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = QTRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ContactUs)!,
            toChild: QTRouteResolver.DefaultAction.ToChildNoOp(),
            toParent: ToParentDismissModalResolver()
        )
        viewController.routeDriver = AppRoute.driver
    }
}
