
import UIKit

func HelpToChildResolver() -> QTRouteResolver.ResolveToChild {
    return { route, from, input, completion in
        guard let vc = from as? HelpViewController else { return /* abort */ }
        switch (route.id) {
        case AppRoute.id.ContactUs:
            vc.segueRouteCompletion = completion
            vc.performSegue(withIdentifier: "ToContacts", sender: nil)
        case AppRoute.id.MessageCenter:
            vc.segueRouteCompletion = completion
            vc.performSegue(withIdentifier: "ToMessageCenter", sender: nil)
        default:
            break
        }
    }
}
