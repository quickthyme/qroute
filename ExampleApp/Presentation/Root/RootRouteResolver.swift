
import UIKit

private let RouteTab: [QTRouteId:Int] = [
    AppRoute.id.ToDo:0,
    AppRoute.id.Help:1
]

class RootRouteResolver: QTRouteResolving {

    func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, completion: @escaping QTRoutableCompletion) {
        guard let rootVC = from as? RootViewController,
            let rootTabBarController = rootVC.rootTabBarController else { return /* abort */ }

        if let index = RouteTab[route.id] {
            rootTabBarController.selectedIndex = index
            if let navWrapper = rootTabBarController.selectedViewController as? UINavigationController {
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
