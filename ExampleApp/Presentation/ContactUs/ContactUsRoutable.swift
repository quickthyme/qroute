
import UIKit

extension ContactUsViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion) {
        /* no-op */
    }

    func routeToParent(completion: @escaping QTRoutableCompletion) {
        if let presenter = self.presentingViewController {
            presenter.dismiss(animated: true) {
                completion(presenter as? QTRoutable)
            }
        }
    }

    func routeToSelf(completion: @escaping QTRoutableCompletion) {
        completion(self)
    }
}
