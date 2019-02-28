
import UIKit

func ToChildNoOpResolver() -> QTRouteResolver.ResolveToChild {
    return { route, from, input, completion in
        /* no-op */
    }
}
