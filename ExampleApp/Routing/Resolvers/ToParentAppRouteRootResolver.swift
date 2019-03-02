
import QTRoute

func ToParentAppRouteRootResolver() -> QTRouteResolver.ActionType.ToParent {
    return {
        from, input, animated, completion in
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }
}
