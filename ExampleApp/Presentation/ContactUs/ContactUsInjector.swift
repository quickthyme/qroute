
import UIKit

class ContactUsInjector: NSObject {
    @IBOutlet weak var viewController: ContactUsViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewController.route = AppRoute.plan.findDescendant(AppRoute.id.ContactUs)!
        viewController.routeResolver = ContactUsRouteResolver()
        viewController.routeDriver = AppRoute.driver
    }
}
