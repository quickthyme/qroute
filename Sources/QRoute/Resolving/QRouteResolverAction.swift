
public extension QRouteResolver {

    public struct ActionType {
        public typealias ToChild  = (QRoute, QRoutable, QRoutableInput, Bool, @escaping QRoutableCompletion) -> ()
        public typealias ToParent = (QRoutable, QRoutableInput, Bool, @escaping QRoutableCompletion) -> ()
        public typealias ToSelf   = (QRoutable, QRoutableInput, Bool, @escaping QRoutableCompletion) -> ()
    }

    public struct DefaultAction {

        public static func ToSelfNoOp() -> ActionType.ToSelf {
            return { _, _, _, _ in /* no-op */ }
        }

        public static func ToChildNoOp() -> ActionType.ToChild {
            return { _, _, _, _, _ in /* no-op */ }
        }

        public static func ToParentNoOp() -> ActionType.ToParent {
            return { _, _, _, _ in /* no-op */ }
        }

        public static func ToSelf() -> ActionType.ToSelf {
            return { from, input, _, completion  in
                QRouteResolver.mergeInputDependencies(target: from, input: input)
                completion(from)
            }
        }

        public static func ToChildKeyed(_ actions: [QRouteId:ActionType.ToChild],
                                        `default`: ActionType.ToChild? = nil) -> ActionType.ToChild {
            return {
                actions[$0.id]?($0, $1, $2, $3, $4)
                    ?? `default`?($0, $1, $2, $3, $4)
            }
        }
    }
}

