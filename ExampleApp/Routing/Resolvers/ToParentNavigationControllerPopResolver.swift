
import UIKit

func ToParentNavigationControllerPopResolver() -> QTRouteResolver.ToParent {
    return { from, input, completion in
        guard let fromVC = from as? UIViewController,
            let navController = fromVC.navigationController else { return }
        navController.popViewController(animated: true) {
            if let parent = navController.topViewController as? QTRoutable {
                completion(parent)
            }
        }
    }
}
