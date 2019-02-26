
import UIKit

extension ToDoViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion) {
        switch (route.id) {
        case AppRoute.id.ToDoDetail:
            let storyboard = UIStoryboard(name: "ToDoDetail", bundle: Bundle(for: type(of: self)))
            if let vc = storyboard.instantiateInitialViewController() {
                navigationController?.pushViewController(vc, animated: true, completion: {
                    completion(vc as? QTRoutable)
                })
            }
        default:
            /* might be modal or some other... */
            break
        }
    }

    func routeToParent(completion: @escaping QTRoutableCompletion) {
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }

    func routeToSelf(completion: @escaping QTRoutableCompletion) {
        completion(self)
    }
}
