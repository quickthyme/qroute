
import UIKit

class ToDoRouteResolver: QTRouteResolving {

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        guard let fromVC = from as? UIViewController else { return }
        if (route.id == AppRoute.id.ToDoDetail),
            let todoId = input["todoId"] as? String,
            let vc = StoryboardLoader.loadViewController(from: "ToDoDetail") as? ToDoDetailViewController {
            vc.todoId = todoId
            fromVC.navigationController?.pushViewController(vc, animated: true, completion: {
                completion(vc)
            })
        }
    }

    func resolveRouteToParent(from: QTRoutable, input: QTRouteResolvingInput, completion: @escaping QTRoutableCompletion) {
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }
}
