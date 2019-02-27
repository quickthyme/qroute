
import UIKit

class ToDoDetailRouteResolver: QTRouteResolving {

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        if route.id == AppRoute.id.ContactUs {
            if let vc = StoryboardLoader.loadViewController(from: "ContactUs") {
                (from as? UIViewController)?.present(vc, animated: true) {
                    completion(vc as? QTRoutable)
                }
            }
        }
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        guard let fromVC = from as? UIViewController,
            let navController = fromVC.navigationController else { return }
        navController.popViewController(animated: true) {
            if let parent = navController.topViewController as? QTRoutable {
                completion(parent)
            }
        }
    }
}
