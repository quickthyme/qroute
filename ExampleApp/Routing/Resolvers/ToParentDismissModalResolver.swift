
import UIKit
import QTRoute

func ToParentDismissModalResolver() -> QTRouteResolver.ActionType.ToParent {
    return {
        from, input, animated, completion in

        guard
            let fromVC = from as? UIViewController,
            let presenter = fromVC.presentingViewController
            else { return }

        presenter.dismiss(animated: animated) {

            if let routable = presenter as? QTRoutable {
                QTRouteResolver.mergeInputDependencies(target: routable, input: input)
                completion(routable)
            }
        }
    }
}
