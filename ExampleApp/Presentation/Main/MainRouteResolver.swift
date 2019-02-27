
import UIKit

private let RouteTab: [QTRouteId:Int] = [
    AppRoute.id.ToDo:0,
    AppRoute.id.Help:1
]

class MainRouteResolver: QTRouteResolving {

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        guard let mainVC = from as? MainViewController,
            let mainTabBarController = mainVC.mainTabBarController else { return /* abort */ }

        if let index = RouteTab[route.id] {
            mainTabBarController.selectedIndex = index
            if let navWrapper = mainTabBarController.selectedViewController as? UINavigationController {
                navWrapper.popToRootViewController(animated: false)
                if let routable = navWrapper.topViewController as? QTRoutable {
                    completion(routable)
                }
            }
        }
    }

    func resolveRouteToParent(from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        assertionFailure("cannot route beyond root!")
    }
}
