
import UIKit

class HelpRouteResolver: QTRouteResolving {

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        guard let vc = from as? HelpViewController else { return /* abort */ }
        switch (route.id) {
        case AppRoute.id.ContactUs:
            vc.segueRouteCompletion = completion
            vc.performSegue(withIdentifier: "ToContacts", sender: nil)
        case AppRoute.id.MessageCenter:
            vc.segueRouteCompletion = completion
            vc.performSegue(withIdentifier: "ToMessageCenter", sender: nil)
        default:
            break
        }
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }
}

