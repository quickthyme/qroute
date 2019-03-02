
internal final class QTRouteDriverStep {

    static func perform(_ routable: QTRoutable, _ pathNode: QTRoutePathNode, _ input: QTRoutableInput,
                        _ animated: Bool,
                        _ stepCompletion: @escaping QTRoutableCompletion) {

        guard let resolver = routable.routeResolver else { return }
        switch (pathNode) {

        case let .DOWN(nextRoute):
            resolver.resolveRouteToChild(nextRoute, from: routable, input: input,
                                         animated: animated,
                                         completion: stepCompletion)
        case .SELF:
            resolver.resolveRouteToSelf(from: routable, input: input,
                                        animated: animated,
                                        completion: stepCompletion)
        case .UP:
            resolver.resolveRouteToParent(from: routable, input: input,
                                          animated: animated,
                                          completion: stepCompletion)
        }
    }
}
