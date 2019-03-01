
import UIKit

private let RouteTab: [QTRouteId:Int] = [
    AppRoute.id.ToDo:0,
    AppRoute.id.Help:1
]

func RootToChildResolver() -> QTRouteResolver.ToChild {
    return {
        route, from, input, animated, completion in

        guard
            let rootVC = from as? RootViewController,
            let rootTabBarController = rootVC.rootTabBarController,
            let index = RouteTab[route.id]
            else { return /* abort */ }

        rootTabBarController.selectedIndex = index

        if let navWrapper = rootTabBarController.selectedViewController as? UINavigationController {
            navWrapper.popToRootViewController(animated: animated) {

                if let routable = navWrapper.topViewController as? QTRoutable {
                    QTRouteResolver.mergeInputDependencies(target: routable, input: input)
                    completion(routable)
                }
            }
        }
    }
}

func RootToParentResolver() -> QTRouteResolver.ToParent {
    return { _, _, _, _ in
        assertionFailure("cannot route beyond root!")
    }
}
