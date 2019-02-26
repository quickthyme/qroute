
import UIKit

extension ToDoViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping (QTRoutable) -> ()) {
        switch (route.id) {
        case AppRoute.id.ToDoDetail:
            break
        default:
            /* might be modal or some other... */
            break
        }
    }

    func routeToParent(completion: @escaping (QTRoutable) -> ()) {
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }

    func routeToSelf(completion: @escaping (QTRoutable) -> ()) {
        completion(self)
    }
}
