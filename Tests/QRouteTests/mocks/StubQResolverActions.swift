
import QRoute

public class StubQResolverActions {
    func reset() {
        didCall_ToChild1 = false
        didCall_ToChild2 = false
        didCall_ToChild3 = false
        didCall_ToParent = false
        didCall_ToSelf = false
    }

    public var didCall_ToChild1 = false
    public func ToChild1() -> QRouteResolver.ActionType.ToChild {
        return { [weak self] _, _, _, _, _ in
            self?.didCall_ToChild1 = true
        }
    }

    public var didCall_ToChild2 = false
    public func ToChild2() -> QRouteResolver.ActionType.ToChild {
        return { [weak self] _, _, _, _, _ in
            self?.didCall_ToChild2 = true
        }
    }

    public var didCall_ToChild3 = false
    public func ToChild3() -> QRouteResolver.ActionType.ToChild {
        return { [weak self] _, _, _, _, _ in
            self?.didCall_ToChild3 = true
        }
    }

    public var didCall_ToParent = false
    public func ToParent() -> QRouteResolver.ActionType.ToParent {
        return { [weak self] _, _, _, _ in
            self?.didCall_ToParent = true
        }
    }

    public var didCall_ToSelf = false
    public func ToSelf() -> QRouteResolver.ActionType.ToSelf {
        return { [weak self] _, _, _, _ in
            self?.didCall_ToSelf = true
        }
    }
}
