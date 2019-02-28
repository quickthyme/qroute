
import UIKit

private let RouteTab: [QTRouteId:Int] = [
    AppRoute.id.ToDo:0,
    AppRoute.id.Help:1
]

func RootToChildResolver() -> QTRouteResolver.ResolveToChild {
    return { route, from, input, completion in
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
}

func RootToParentResolver() -> QTRouteResolver.ResolveToParent {
    return { _, _, _ in
        assertionFailure("cannot route beyond root!")
    }
}
