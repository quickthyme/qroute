
public extension QTRouteResolver {

    public struct ActionType {
        public typealias ToChild  = (QTRoute, QTRoutable, QTRoutableInput, Bool, @escaping QTRoutableCompletion) -> ()
        public typealias ToParent = (QTRoutable, QTRoutableInput, Bool, @escaping QTRoutableCompletion) -> ()
        public typealias ToSelf   = (QTRoutable, QTRoutableInput, Bool, @escaping QTRoutableCompletion) -> ()
    }

    public struct DefaultAction {

        public static func ToSelf() -> ActionType.ToSelf {
            return { from, input, _, completion  in
                QTRouteResolver.mergeInputDependencies(target: from, input: input)
                completion(from)
            }
        }

        public static func ToSelfNoOp() -> ActionType.ToSelf {
            return { _, _, _, _ in /* no-op */ }
        }

        public static func ToChildNoOp() -> ActionType.ToChild {
            return { _, _, _, _, _ in /* no-op */ }
        }

        public static func ToParentNoOp() -> ActionType.ToParent {
            return { _, _, _, _ in /* no-op */ }
        }
    }
}

