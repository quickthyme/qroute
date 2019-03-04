
public final class QRouteDriver: QRouteDriving {
    public init() {}

    public func driveParent(from source: QRoutable, input: QRoutableInput?, animated:Bool, completion: QRoutableCompletion?) {
        guard let parentId = source.routeResolver?.route.parent?.id else { completion?(nil); return }
        driveTo(parentId, from: source, input: input ?? [:], animated: animated, completion: completion)
    }

    public func driveSub(_ targetId: QRouteId, from source: QRoutable, input: QRoutableInput?, animated:Bool, completion: QRoutableCompletion?) {
        guard let clonePath = buildClonePath(to: targetId, from: source) else { completion?(nil); return }
        QRouteDriver.nextStep(clonePath, source, input ?? [:], animated, completion)
    }

    public func driveTo(_ targetId: QRouteId, from source: QRoutable, input: QRoutableInput?, animated:Bool, completion: QRoutableCompletion?) {
        guard let path = source.routeResolver?.route.findPath(to: targetId) else { completion?(nil); return }
        QRouteDriver.nextStep(path, source, input ?? [:], animated, completion)
    }
}

fileprivate extension QRouteDriver {

    func buildClonePath(to targetId: QRouteId, from source: QRoutable) -> QRoutePath? {
        guard
            let sourceRoute = source.routeResolver?.route,
            let target = sourceRoute.findPath(to: targetId).last?.route
            else { return nil }
        return [.DOWN( QRoute(deepClone: target).applyParent(sourceRoute) )]
    }

    static func nextStep(_ path: QRoutePath, _ routable: QRoutable?, _ input: QRoutableInput,
                         _ animated:Bool,
                         _ finalCompletion: QRoutableCompletion?) {
        guard let nextRoutable = routable, (path.count > 0)
            else { finalCompletion?(routable); return }
        let nextCompletion = nextStepCompletion(path, input, animated, finalCompletion)
        QRouteDriverStep.perform(nextRoutable, path[0], input, animated, nextCompletion)
    }

    static func nextStepCompletion(_ path: QRoutePath, _ input: QRoutableInput,
                                   _ animated:Bool,
                                   _ finalCompletion: QRoutableCompletion?) -> QRoutableCompletion {
        return {
            QRouteDriver.nextStep(QRoutePath( path.dropFirst() ), $0, input, animated, finalCompletion)
        }
    }
}
