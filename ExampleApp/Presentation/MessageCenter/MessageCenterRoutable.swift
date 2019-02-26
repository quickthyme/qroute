
import UIKit

extension MessageCenterViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion) {
        /* no-op */
    }

    func routeToParent(completion: @escaping QTRoutableCompletion) {
        guard let navController = self.navigationController else { return }
        navController.popViewController(animated: true) {
            if let parent = navController.topViewController as? QTRoutable {
                completion(parent)
            }
        }
    }
}
