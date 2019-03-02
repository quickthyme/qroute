
public typealias QTRoutePath = Array<QTRoutePathNode>

public enum QTRoutePathNode: Hashable {
    case SELF(QTRoute)
    case UP(QTRoute)
    case DOWN(QTRoute)

    public var route: QTRoute {
        switch (self) {
        case let .SELF(route):  return route
        case let .UP(route):    return route
        case let .DOWN(route):  return route
        }
    }
}

public extension QTRoute {
    public func findPath(to targetId: QTRouteId) -> QTRoutePath {
        guard (targetId != "") else { return [] }
        if (targetId == self.id) {
            return [.SELF(self)]
        } else if let discoveredDescendant = self.findDescendant(targetId) {
            return QTRoute.buildPath(downTo: discoveredDescendant, from: self.id)
        } else if let discoveredAncestor = self.findAncestor(targetId) {
            return QTRoute.buildPath(upTo: discoveredAncestor.id, from: self)
        }
        return QTRoute.buildComplexPath(to: targetId, from: self)
    }

    public func findDescendant(_ id: QTRouteId) -> QTRoute? {
        return QTRoute.findDescendant(id, from: self)
    }

    public static func findDescendant(_ id: QTRouteId, from route: QTRoute) -> QTRoute? {
        return route.route(id) ?? route.routes.compactMap { $0.findDescendant(id) } .first
    }

    public func findAncestor(_ id: QTRouteId) -> QTRoute? {
        return QTRoute.findAncestor(id, from: self)
    }

    public static func findAncestor(_ id: QTRouteId, from route:QTRoute) -> QTRoute? {
        guard let parent = route.parent else { return nil }
        return (parent.id == id) ? parent : findAncestor(id, from: parent)
    }

    public func findRoot() -> QTRoute {
        return QTRoute.findRoot(from: self)
    }

    public static func findRoot(from route:QTRoute) -> QTRoute {
        return (route.parent == nil) ? route : findRoot(from: route.parent!)
    }

    public func findLowestCommonAncestor(otherRoute: QTRoute, root: QTRoute? = nil) -> QTRoute {
        return QTRoute.findLowestCommonAncestor(lhs: self, rhs: otherRoute, root: root)
    }

    public static func findLowestCommonAncestor(lhs: QTRoute, rhs: QTRoute, root: QTRoute? = nil) -> QTRoute {
        let root = root ?? findRoot(from: lhs)
        let left:  [QTRoute] = QTRoute.buildPath(upTo: root.id, from: lhs).map { $0.route }
        let right: [QTRoute] = QTRoute.buildPath(upTo: root.id, from: rhs).map { $0.route }
        return left.first { right.contains($0) } ?? root
    }
}

fileprivate extension QTRoute {
    static func buildComplexPath(to targetId: QTRouteId, from: QTRoute) -> QTRoutePath {
        let root = from.findRoot()
        guard let target = root.findDescendant(targetId) else { return [] }
        let ancestor = from.findLowestCommonAncestor(otherRoute: target, root: root)
        return QTRoute.buildPath(to: target, from: from, byWayOf: ancestor)
    }

    static func buildPath(downTo route: QTRoute, from fromId: QTRouteId, currentPath:QTRoutePath = []) -> QTRoutePath {
        if (fromId == route.id) { return currentPath }
        guard let parent = route.parent else { return [.DOWN(route)] + currentPath }
        return buildPath(downTo: parent, from: fromId, currentPath: [.DOWN(route)] + currentPath)
    }

    static func buildPath(upTo toId: QTRouteId, from: QTRoute, currentPath:QTRoutePath = []) -> QTRoutePath {
        if (toId == from.id) { return currentPath }
        guard let parent = from.parent else { return currentPath }
        return buildPath(upTo: toId, from: parent, currentPath: currentPath + [.UP(parent)])
    }

    static func buildPath(to: QTRoute, from: QTRoute, byWayOf ancestor: QTRoute) -> QTRoutePath {
        let startPath = QTRoute.buildPath(upTo: ancestor.id, from: from)
        let endPath = QTRoute.buildPath(downTo: to, from: ancestor.id)
        return startPath + endPath
    }
}
