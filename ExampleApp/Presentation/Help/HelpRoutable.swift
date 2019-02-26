
import UIKit

extension HelpViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping (QTRoutable) -> ()) {
        switch (route.id) {
        case AppRoute.id.ContactUs:
            segueRouteCompletion = completion
            self.performSegue(withIdentifier: "ToContacts", sender: nil)
        case AppRoute.id.MessageCenter:
            segueRouteCompletion = completion
            self.performSegue(withIdentifier: "ToMessageCenter", sender: nil)
        default:
            break
        }
    }

    func routeToParent(completion: @escaping (QTRoutable) -> ()) {
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }

    func routeToSelf(completion: @escaping (QTRoutable) -> ()) {
        completion(self)
    }
}