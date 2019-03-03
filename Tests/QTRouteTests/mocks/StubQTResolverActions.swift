
import QTRoute

public class StubQTResolverActions {
    func reset() {
        didCall_ToChild1 = false
        didCall_ToChild2 = false
        didCall_ToParent = false
        didCall_ToSelf = false
    }

    public var didCall_ToChild1 = false
    public func ToChild1() -> QTRouteResolver.ActionType.ToChild {
        return { [weak self] _, _, _, _, _ in
            self?.didCall_ToChild1 = true
        }
    }

    public var didCall_ToChild2 = false
    public func ToChild2() -> QTRouteResolver.ActionType.ToChild {
        return { [weak self] _, _, _, _, _ in
            self?.didCall_ToChild2 = true
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
