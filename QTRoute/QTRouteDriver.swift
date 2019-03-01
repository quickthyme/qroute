
class QTRouteDriver: QTRouteDriving {
    func driveParent(from source: QTRoutable, input: QTRoutableInput?, animated:Bool, completion: QTRoutableCompletion?) {
        guard let parentId = source.routeResolver?.route.parent?.id else { completion?(nil); return }
        driveTo(parentId, from: source, input: input ?? [:], animated: animated, completion: completion)
    }

    func driveSub(_ targetId: QTRouteId, from source: QTRoutable, input: QTRoutableInput?, animated:Bool, completion: QTRoutableCompletion?) {
        guard let clonePath = QTRouteDriver.buildClonePath(to: targetId, from: source) else { completion?(nil); return }
        QTRouteDriver.routeNext(path: clonePath, routable: source, input: input ?? [:], animated: animated, finalCompletion: completion)
    }

    func driveTo(_ targetId: QTRouteId, from source: QTRoutable, input: QTRoutableInput?, animated:Bool, completion: QTRoutableCompletion?) {
        guard let path = source.routeResolver?.route.findPath(to: targetId) else { completion?(nil); return }
        QTRouteDriver.routeNext(path: path, routable: source, input: input ?? [:], animated: animated, finalCompletion: completion)
    }
}

fileprivate extension QTRouteDriver {
    static func routeNext(path: QTRoutePath, routable: QTRoutable?, input: QTRoutableInput, animated:Bool, finalCompletion: QTRoutableCompletion?) {
        guard let nextRoutable = routable, (path.count > 0) else { finalCompletion?(routable); return }
        let stepCompletion = self.getStepCompletion(path, input, animated, finalCompletion)
        QTRouteDriver.driveRoutable(nextRoutable, path[0], input, animated, stepCompletion)
    }

    static func driveRoutable(_ routable: QTRoutable,
                              _ pathNode: QTRoutePathNode,
                              _ input: QTRoutableInput,
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

    static func getStepCompletion(_ path: QTRoutePath,
                                  _ input: QTRoutableInput,
                                  _ animated:Bool,
                                  _ finalCompletion: QTRoutableCompletion?) -> QTRoutableCompletion {
        return { QTRouteDriver.routeNext(path: QTRoutePath( path.dropFirst() ),
                                         routable: $0,
                                         input: input,
                                         animated: animated,
                                         finalCompletion: finalCompletion) }
    }

    static func buildClonePath(to targetId: QTRouteId, from source: QTRoutable) -> QTRoutePath? {
        guard let sourceRoute = source.routeResolver?.route else { return nil }
        guard let target = sourceRoute.findPath(to: targetId).last?.route else { return nil }
        let clone = QTRoute(deepClone: target)
        clone.parent = sourceRoute
        return [.DOWN(clone)]
    }
}
