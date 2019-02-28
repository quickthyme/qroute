
import UIKit

func ToChildUIStoryboardNavigationControllerPushResolver() -> QTRouteResolver.ToChild {
    return { route, from, input, completion in
        guard
            let fromVC = from as? UIViewController,
            let vc = StoryboardLoader.loadViewController(from: route.id),
            let vcRoutable = vc as? QTRoutable
            else { return }

        QTRouteResolver.mergeInputDependencies(target: vcRoutable, input: input)
        fromVC.navigationController?.pushViewController(vc, animated: true, completion: {
            completion(vcRoutable)
        })
    }
}
