
class QTRouteDriver: QTRouteDriving {
    func driveParent(from source: QTRoutable, completion: QTRouteDrivingCompletion?) {
        guard let parentId = source.route?.parent?.id else { completion?(nil); return }
        driveTo(parentId, from: source, completion: completion)
    }

    func driveSub(_ targetId: QTRouteId, from source: QTRoutable, completion: QTRouteDrivingCompletion?) {
        guard let clonePath = QTRouteDriver.buildClonePath(to: targetId, from: source) else { completion?(nil); return }
        QTRouteDriver.routeNext(path: clonePath, routable: source, finalCompletion: completion)
    }

    func driveTo(_ targetId: QTRouteId, from source: QTRoutable, completion: QTRouteDrivingCompletion?) {
        guard let path = source.route?.findPath(to: targetId) else { completion?(nil); return }
        QTRouteDriver.routeNext(path: path, routable: source, finalCompletion: completion)
    }
}

fileprivate extension QTRouteDriver {
    static func routeNext(path: QTRoutePath, routable: QTRoutable?, finalCompletion: QTRouteDrivingCompletion?) {
        guard let nextRoutable = routable, (path.count > 0) else { finalCompletion?(routable); return }
        let stepCompletion = self.getStepCompletion(path, finalCompletion)
        QTRouteDriver.driveRoutable(nextRoutable, path[0], stepCompletion)
    }

    static func driveRoutable(_ routable: QTRoutable, _ pathNode: QTRoutePathNode, _ stepCompletion: @escaping QTRoutableCompletion) {
        switch (pathNode.direction) {
        case .DOWN:
            routable.routeResolver?.resolveRouteToChild(pathNode.route, from: routable, completion: stepCompletion)
        case .SELF:
            routable.routeResolver?.resolveRouteToSelf(from: routable, completion: stepCompletion)
        case .UP:
            routable.routeResolver?.resolveRouteToParent(from: routable, completion: stepCompletion)
        }
    }

    static func getStepCompletion(_ path: QTRoutePath, _ finalCompletion: QTRouteDrivingCompletion?) -> QTRoutableCompletion {
        return { QTRouteDriver.routeNext(path: QTRoutePath( path.dropFirst() ),
                                         routable: $0,
                                         finalCompletion: finalCompletion) }
    }

    static func buildClonePath(to targetId: QTRouteId, from source: QTRoutable) -> QTRoutePath? {
        guard let sourceRoute = source.route else { return nil }
        guard let target = sourceRoute.findPath(to: targetId).last?.route else { return nil }
        let clone = QTRoute(deepClone: target)
        clone.parent = sourceRoute
        return [QTRoutePathNode(.DOWN, clone)]
    }
}
