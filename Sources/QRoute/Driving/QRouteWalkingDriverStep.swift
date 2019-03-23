
import Dispatch

internal final class QRouteWalkingDriverStep {

    static func perform(_ routable: QRoutable, _ pathNode: QRoutePathNode, _ input: QRouteResolving.Input,
                        _ animated: Bool,
                        _ stepCompletion: @escaping QRouteResolving.Completion) {

        switch (pathNode) {

        case let .DOWN(nextRoute):
            DispatchQueue.main.async {
                routable.routeResolver
                    .resolveRouteToChild(nextRoute, from: routable, input: input,
                                         animated: animated,
                                         completion: stepCompletion)
            }
        case .SELF:
            DispatchQueue.main.async {
                routable.routeResolver
                    .resolveRouteToSelf(from: routable, input: input,
                                        animated: animated,
                                        completion: stepCompletion)
            }
        case .UP:
            DispatchQueue.main.async {
                routable.routeResolver
                    .resolveRouteToParent(from: routable, input: input,
                                          animated: animated,
                                          completion: stepCompletion)
            }
        }
    }
}

