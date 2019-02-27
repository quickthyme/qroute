
import UIKit

class ToDoRouteResolver: QTRouteResolving {

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        guard let fromVC = from as? UIViewController else { return }
        if (route.id == AppRoute.id.ToDoDetail), let vc = StoryboardLoader.loadViewController(from: "ToDoDetail") {
            fromVC.navigationController?.pushViewController(vc, animated: true, completion: {
                completion(vc as? QTRoutable)
            })
        }
    }

    func resolveRouteToParent(from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }
}
