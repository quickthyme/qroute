
import UIKit

class ContactUsRouteResolver: QTRouteResolving {
    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        /* no-op */
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        if let vc = from as? UIViewController,
            let presenter = vc.presentingViewController {
            presenter.dismiss(animated: true) {
                completion(presenter as? QTRoutable)
            }
        }
    }
}
