
import UIKit

private let RouteTab: [QTRouteId:Int] = [
    AppRoute.id.ToDo:0,
    AppRoute.id.Help:1
]

extension MainViewController: QTRoutable {

    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion) {
        if let index = RouteTab[route.id] {
            mainTabBarController?.selectedIndex = index
            if let navWrapper = mainTabBarController?.selectedViewController as? UINavigationController {
                navWrapper.popToRootViewController(animated: false)
                if let routable = navWrapper.topViewController as? QTRoutable {
                    completion(routable)
                }
            }
        } else {
            /* might be modal or some other... */
        }
    }

    func routeToParent(completion: @escaping QTRoutableCompletion) {
        assertionFailure("cannot route beyond root!")
    }

    func routeToSelf(completion: @escaping QTRoutableCompletion) {
        completion(self)
    }
}
