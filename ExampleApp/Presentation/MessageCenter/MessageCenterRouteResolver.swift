
import UIKit

class MessageCenterRouteResolver: QTRouteResolving {
    let route: QTRoute

    required init(_ route: QTRoute) {
        self.route = route
    }

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        guard let vc = from as? UIViewController,
            let navController = vc.navigationController,
            let newVc = StoryboardLoader.loadViewController(from: AppRoute.id.MessageCenter)
            else { return }

        navController.pushViewController(newVc, animated: true) {
            if let newRoutable = navController.topViewController as? QTRoutable {
                completion(newRoutable)
            }
        }
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput, completion: @escaping QTRoutableCompletion) {
        guard let vc = from as? UIViewController,
            let navController = vc.navigationController else { return }
        navController.popViewController(animated: true) {
            if let parent = navController.topViewController as? QTRoutable {
                completion(parent)
            }
        }
    }
}
