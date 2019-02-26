
import UIKit

extension ToDoDetailViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion) {
        if route.id == AppRoute.id.ContactUs {
            if let vc = StoryboardLoader.loadViewController(from: "ContactUs") {
                self.present(vc, animated: true) {
                    completion(vc as? QTRoutable)
                }
            }
        }
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
