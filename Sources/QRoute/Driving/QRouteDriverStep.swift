
internal final class QRouteDriverStep {

    static func perform(_ routable: QRoutable, _ pathNode: QRoutePathNode, _ input: QRoutableInput,
                        _ animated: Bool,
                        _ stepCompletion: @escaping QRoutableCompletion) {

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
