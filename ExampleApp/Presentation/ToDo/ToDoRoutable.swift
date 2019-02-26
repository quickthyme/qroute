
import UIKit

extension ToDoViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion) {
        switch (route.id) {
        case AppRoute.id.ToDoDetail:
            if let vc = StoryboardLoader.loadViewController(from: "ToDoDetail") {
                navigationController?.pushViewController(vc, animated: true, completion: {
                    completion(vc as? QTRoutable)
                })
            }
        default:
            break
        }
    }

    func routeToParent(completion: @escaping QTRoutableCompletion) {
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }
}
