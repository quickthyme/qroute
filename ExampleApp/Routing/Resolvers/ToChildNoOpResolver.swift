
import UIKit

func ToChildNoOpResolver() -> QTRouteResolver.ToChild {
    return { route, from, input, completion in
        /* no-op */
    }
}
