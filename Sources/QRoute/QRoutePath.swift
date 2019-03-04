
public typealias QRoutePath = Array<QRoutePathNode>

public enum QRoutePathNode: Hashable {
    case SELF(QRoute)
    case UP(QRoute)
    case DOWN(QRoute)

    public var route: QRoute {
        switch (self) {
        case let .SELF(route):  return route
        case let .UP(route):    return route
        case let .DOWN(route):  return route
        }
    }
}

public extension QRoute {
    public func findPath(to targetId: QRouteId) -> QRoutePath {
        guard (targetId != "") else { return [] }
        if (targetId == self.id) {
            return [.SELF(self)]
        } else if let discoveredDescendant = self.findDescendant(targetId) {
            return QRoute.buildPath(downTo: discoveredDescendant, from: self.id)
        } else if let discoveredAncestor = self.findAncestor(targetId) {
            return QRoute.buildPath(upTo: discoveredAncestor.id, from: self)
        }
        return QRoute.buildComplexPath(to: targetId, from: self)
    }

    public func findDescendant(_ id: QRouteId) -> QRoute? {
        return QRoute.findDescendant(id, from: self)
    }

    public static func findDescendant(_ id: QRouteId, from route: QRoute) -> QRoute? {
        return route.route(id) ?? route.routes.compactMap { $0.findDescendant(id) } .first
    }

    public func findAncestor(_ id: QRouteId) -> QRoute? {
        return QRoute.findAncestor(id, from: self)
    }

    public static func findAncestor(_ id: QRouteId, from route:QRoute) -> QRoute? {
        guard let parent = route.parent else { return nil }
        return (parent.id == id) ? parent : findAncestor(id, from: parent)
    }

    public func findRoot() -> QRoute {
        return QRoute.findRoot(from: self)
    }

    public static func findRoot(from route:QRoute) -> QRoute {
        return (route.parent == nil) ? route : findRoot(from: route.parent!)
    }

    public func findLowestCommonAncestor(otherRoute: QRoute, root: QRoute? = nil) -> QRoute {
        return QRoute.findLowestCommonAncestor(lhs: self, rhs: otherRoute, root: root)
    }

    public static func findLowestCommonAncestor(lhs: QRoute, rhs: QRoute, root: QRoute? = nil) -> QRoute {
        let root = root ?? findRoot(from: lhs)
        let left:  [QRoute] = QRoute.buildPath(upTo: root.id, from: lhs).map { $0.route }
        let right: [QRoute] = QRoute.buildPath(upTo: root.id, from: rhs).map { $0.route }
        return left.first { right.contains($0) } ?? root
    }
}

fileprivate extension QRoute {
    static func buildComplexPath(to targetId: QRouteId, from: QRoute) -> QRoutePath {
        let root = from.findRoot()
        guard let target = root.findDescendant(targetId) else { return [] }
        let ancestor = from.findLowestCommonAncestor(otherRoute: target, root: root)
        return QRoute.buildPath(to: target, from: from, byWayOf: ancestor)
    }

    static func buildPath(downTo route: QRoute, from fromId: QRouteId, currentPath:QRoutePath = []) -> QRoutePath {
        if (fromId == route.id) { return currentPath }
        guard let parent = route.parent else { return [.DOWN(route)] + currentPath }
        return buildPath(downTo: parent, from: fromId, currentPath: [.DOWN(route)] + currentPath)
    }

    static func buildPath(upTo toId: QRouteId, from: QRoute, currentPath:QRoutePath = []) -> QRoutePath {
        if (toId == from.id) { return currentPath }
        guard let parent = from.parent else { return currentPath }
        return buildPath(upTo: toId, from: parent, currentPath: currentPath + [.UP(parent)])
    }

    static func buildPath(to: QRoute, from: QRoute, byWayOf ancestor: QRoute) -> QRoutePath {
        let startPath = QRoute.buildPath(upTo: ancestor.id, from: from)
        let endPath = QRoute.buildPath(downTo: to, from: ancestor.id)
        return startPath + endPath
    }
}
