
import UIKit

func ToParentDismissModalResolver() -> QTRouteResolver.ResolveToParent {
    return { from, input, completion in
        guard
            let fromVC = from as? UIViewController,
            let presenter = fromVC.presentingViewController
            else { return }

        presenter.dismiss(animated: true) {
            completion(presenter as? QTRoutable)
        }
    }
}
