
import UIKit

extension MessageCenterViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping (QTRoutable) -> ()) {
        /* no-op */
    }

    func routeToParent(completion: @escaping (QTRoutable) -> ()) {
        guard let navController = self.navigationController else { return }
        navController.popViewController(animated: true) {
            if let parent = navController.topViewController as? QTRoutable {
                completion(parent)
            }
        }
    }

    func routeToSelf(completion: @escaping (QTRoutable) -> ()) {
        completion(self)
    }
}
