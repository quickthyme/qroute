
func ToParentAppRouteRootResolver() -> QTRouteResolver.ResolveToParent {
    return { from, input, completion in
        guard let parent = AppRoute.rootRoutable else { return /* abort */ }
        completion(parent)
    }
}
