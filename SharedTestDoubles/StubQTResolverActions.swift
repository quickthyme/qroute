
import QTRoute

public class StubQTResolverActions {

    public var didCall_ToChild = false
    public func ToChild() -> QTRouteResolver.ActionType.ToChild {
        return { [weak self] _, _, _, _, _ in
            self?.didCall_ToChild = true
        }
    }

    public var didCall_ToParent = false
    public func ToParent() -> QTRouteResolver.ActionType.ToParent {
        return { [weak self] _, _, _, _ in
            self?.didCall_ToParent = true
        }
    }

    public var didCall_ToSelf = false
    public func ToSelf() -> QTRouteResolver.ActionType.ToSelf {
        return { [weak self] _, _, _, _ in
            self?.didCall_ToSelf = true
        }
    }
}
