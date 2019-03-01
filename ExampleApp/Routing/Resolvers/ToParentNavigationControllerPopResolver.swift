
import UIKit

func ToParentNavigationControllerPopResolver() -> QTRouteResolver.ToParent {
    return {
        from, input, animated, completion in

        guard let fromVC = from as? UIViewController,
            let navController = fromVC.navigationController else { return }

        navController.popViewController(animated: animated) {

            if let parent = navController.topViewController as? QTRoutable {
                QTRouteResolver.mergeInputDependencies(target: parent, input: input)
                completion(parent)
            }
        }
    }
}
