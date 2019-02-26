
class QTRouter: QTRouting {
    func routeTo(_ targetId: QTRouteId, from source: QTRoutable, completion: QTRoutingCompletion?) {
        guard let path = source.route?.findPath(to: targetId) else { completion?(); return }
        QTRouter.routeNext(path: path, routable: source, finalCompletion: completion)
    }

    func routeSub(_ targetId: QTRouteId, from source: QTRoutable, completion: QTRoutingCompletion?) {
        guard let clonePath = QTRouter.buildClonePath(to: targetId, from: source) else { completion?(); return }
        QTRouter.routeNext(path: clonePath, routable: source, finalCompletion: completion)
    }
}

fileprivate extension QTRouter {
    static func routeNext(path: QTRoutePath, routable: QTRoutable?, finalCompletion: QTRoutingCompletion?) {
        guard let routable = routable, (path.count > 0) else { finalCompletion?(); return }
        let stepCompletion = self.getStepCompletion(path, finalCompletion)
        QTRouter.driveRoutable(routable, path[0], stepCompletion)
    }

    static func driveRoutable(_ routable: QTRoutable, _ pathNode: QTRoutePathNode, _ stepCompletion: @escaping QTRoutableCompletion) {
        switch (pathNode.direction) {
        case .DOWN:
            routable.routeToChild(pathNode.route, completion: stepCompletion)
        case .SELF:
            routable.routeToSelf(completion: stepCompletion)
        case .UP:
            routable.routeToParent(completion: stepCompletion)
        }
    }

    static func getStepCompletion(_ path: QTRoutePath, _ finalCompletion: QTRoutingCompletion?) -> QTRoutableCompletion {
        return { QTRouter.routeNext(path: QTRoutePath( path.dropFirst() ),
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
