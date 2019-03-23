
public final class QRouteWalkingDriver: QRouteDriving {
    public init() {}

    public func driveParent(from source: QRoutable, input: QRouteResolving.Input?, animated:Bool, completion: QRouteResolving.Completion?) {
        guard let parentId = source.routeResolver.route.parent?.id else { completion?(nil); return }
        driveTo(parentId, from: source, input: input ?? [:], animated: animated, completion: completion)
    }

    public func driveSub(_ targetId: QRouteId, from source: QRoutable, input: QRouteResolving.Input?, animated:Bool, completion: QRouteResolving.Completion?) {
        guard let clonePath = buildClonePath(to: targetId, from: source) else { completion?(nil); return }
        type(of: self).nextStep(clonePath, source, input ?? [:], animated, completion)
    }

    public func driveTo(_ targetId: QRouteId, from source: QRoutable, input: QRouteResolving.Input?, animated:Bool, completion: QRouteResolving.Completion?) {
        let path = source.routeResolver.route.findPath(to: targetId)
        type(of: self).nextStep(path, source, input ?? [:], animated, completion)
    }
}

fileprivate extension QRouteWalkingDriver {

    func buildClonePath(to targetId: QRouteId, from source: QRoutable) -> QRoutePath? {
        let sourceRoute = source.routeResolver.route
        guard let target = sourceRoute.findPath(to: targetId).last?.route else { return nil }
        return [.DOWN( QRoute(deepClone: target).applyParent(sourceRoute) )]
    }

    static func nextStep(_ path: QRoutePath, _ routable: QRoutable?, _ input: QRouteResolving.Input,
                         _ animated:Bool,
                         _ finalCompletion: QRouteResolving.Completion?) {
        guard let nextRoutable = routable, (path.count > 0)
            else { finalCompletion?(routable); return }
        let nextCompletion = nextStepCompletion(path, input, animated, finalCompletion)
        QRouteWalkingDriverStep.perform(nextRoutable, path[0], input, animated, nextCompletion)
    }

    static func nextStepCompletion(_ path: QRoutePath, _ input: QRouteResolving.Input,
                                   _ animated:Bool,
                                   _ finalCompletion: QRouteResolving.Completion?) -> QRouteResolving.Completion {
        return {
            QRouteWalkingDriver.nextStep(QRoutePath( path.dropFirst() ), $0, input, animated, finalCompletion)
        }
    }
}
