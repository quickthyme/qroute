
import UIKit

class ContactUsRouteResolver: QTRouteResolving {
    let route: QTRoute

    required init(_ route: QTRoute) {
        self.route = route
    }

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        /* no-op */
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        if let vc = from as? UIViewController,
            let presenter = vc.presentingViewController {
            presenter.dismiss(animated: true) {
                completion(presenter as? QTRoutable)
            }
        }
    }
}
