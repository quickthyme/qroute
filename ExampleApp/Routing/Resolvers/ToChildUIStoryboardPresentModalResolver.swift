
import UIKit

func ToChildUIStoryboardPresentModalResolver() -> QTRouteResolver.ToChild {
    return { route, from, input, animated, completion in
        guard
            let fromVC = from as? UIViewController,
            let vc = StoryboardLoader.loadViewController(from: route.id),
            let vcRoutable = vc as? QTRoutable
            else { return }

        QTRouteResolver.mergeInputDependencies(target: vcRoutable, input: input)
        fromVC.present(vc, animated: animated) {
            completion(vcRoutable)
        }
    }
}
