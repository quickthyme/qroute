
import UIKit

func ToChildNoOpResolver() -> QTRouteResolver.ToChild {
    return { _, _, _, _, _ in /* no-op */ }
}
