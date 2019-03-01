
class StubResolvers {

    var didCall_ToChild = false
    func ToChild() -> QTRouteResolver.ToChild {
        return { [weak self] _, _, _, _, _ in
            self?.didCall_ToChild = true
        }
    }

    var didCall_ToParent = false
    func ToParent() -> QTRouteResolver.ToParent {
        return { [weak self] _, _, _, _ in
            self?.didCall_ToParent = true
        }
    }

    var didCall_ToSelf = false
    func ToSelf() -> QTRouteResolver.ToSelf {
        return { [weak self] _, _, _, _ in
            self?.didCall_ToSelf = true
        }
    }
}
