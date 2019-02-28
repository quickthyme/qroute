
import UIKit

class ContactUsInjector: NSObject {
    @IBOutlet weak var viewController: ContactUsViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.routeResolver = ContactUsRouteResolver(
            AppRoute.plan.findDescendant(AppRoute.id.ContactUs)!
        )
        viewController.routeDriver = AppRoute.driver
    }
}
