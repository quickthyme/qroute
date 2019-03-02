
class QTRouteDriver: QTRouteDriving {

    func driveParent(from source: QTRoutable, input: QTRoutableInput?, animated:Bool, completion: QTRoutableCompletion?) {
        guard let parentId = source.routeResolver?.route.parent?.id else { completion?(nil); return }
        driveTo(parentId, from: source, input: input ?? [:], animated: animated, completion: completion)
    }

    func driveSub(_ targetId: QTRouteId, from source: QTRoutable, input: QTRoutableInput?, animated:Bool, completion: QTRoutableCompletion?) {
        guard let clonePath = buildClonePath(to: targetId, from: source) else { completion?(nil); return }
        QTRouteDriver.nextStep(clonePath, source, input ?? [:], animated, completion)
    }

    func driveTo(_ targetId: QTRouteId, from source: QTRoutable, input: QTRoutableInput?, animated:Bool, completion: QTRoutableCompletion?) {
        guard let path = source.routeResolver?.route.findPath(to: targetId) else { completion?(nil); return }
        QTRouteDriver.nextStep(path, source, input ?? [:], animated, completion)
    }
}

fileprivate extension QTRouteDriver {

    func buildClonePath(to targetId: QTRouteId, from source: QTRoutable) -> QTRoutePath? {
        guard
            let sourceRoute = source.routeResolver?.route,
            let target = sourceRoute.findPath(to: targetId).last?.route
            else { return nil }
        return [.DOWN( QTRoute(deepClone: target).applyParent(sourceRoute) )]
    }

    static func nextStep(_ path: QTRoutePath, _ routable: QTRoutable?, _ input: QTRoutableInput,
                         _ animated:Bool,
                         _ finalCompletion: QTRoutableCompletion?) {
        guard let nextRoutable = routable, (path.count > 0)
            else { finalCompletion?(routable); return }
        let nextCompletion = nextStepCompletion(path, input, animated, finalCompletion)
        QTRouteDriverStep.perform(nextRoutable, path[0], input, animated, nextCompletion)
    }

    static func nextStepCompletion(_ path: QTRoutePath, _ input: QTRoutableInput,
                                   _ animated:Bool,
                                   _ finalCompletion: QTRoutableCompletion?) -> QTRoutableCompletion {
        return {
            QTRouteDriver.nextStep(QTRoutePath( path.dropFirst() ), $0, input, animated, finalCompletion)
        }
    }
}
