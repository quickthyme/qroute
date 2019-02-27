
import UIKit

class MessageCenterRouteResolver: QTRouteResolving {

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        /* no-op */
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        guard let vc = from as? UIViewController,
            let navController = vc.navigationController else { return }
        navController.popViewController(animated: true) {
            if let parent = navController.topViewController as? QTRoutable {
                completion(parent)
            }
        }
    }
}
