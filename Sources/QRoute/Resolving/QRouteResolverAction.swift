
public extension QRouteResolver {

    struct ActionType {
        public typealias ToChild  = (QRoute, QRoutable, Input, Bool, @escaping Completion) -> ()
        public typealias ToParent = (QRoutable, Input, Bool, @escaping Completion) -> ()
        public typealias ToSelf   = (QRoutable, Input, Bool, @escaping Completion) -> ()
    }

    struct DefaultAction {

        public static func ToSelfNoOp() -> ActionType.ToSelf {
            return { _, _, _, _ in }
        }

        public static func ToChildNoOp() -> ActionType.ToChild {
            return { _, _, _, _, _ in }
        }

        public static func ToParentNoOp() -> ActionType.ToParent {
            return { _, _, _, _ in }
        }

        public static func ToSelf() -> ActionType.ToSelf {
            return { from, input, _, completion  in
                QRouteResolver.mergeInputDependencies(resolver: from.routeResolver, input: input)
                completion(from)
            }
        }

        public static func ToChildSwitch(_ caseMatchId: [ QRouteId: ActionType.ToChild ],
                                         `default`: ActionType.ToChild? = nil) -> ActionType.ToChild {
            return {
                caseMatchId[$0.id]?($0, $1, $2, $3, $4)
                    ?? `default`?($0, $1, $2, $3, $4)
            }
        }
    }
}

