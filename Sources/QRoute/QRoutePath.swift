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
    func findPath(to targetId: QRouteId) -> QRoutePath {
        return pathIfEmpty(targetId)
            ?? pathIfSelf(targetId)
            ?? pathIfDescendant(targetId)
            ?? pathIfAncestor(targetId)
            ?? QRoute.buildComplexPath(to: targetId,
                                       from: self)
    }

    func findLowestCommonAncestor(otherRoute: QRoute, root: QRoute? = nil) -> QRoute {
        return QRoute.findLowestCommonAncestor(lhs: self, rhs: otherRoute, root: root)
    }

    static func findLowestCommonAncestor(lhs: QRoute, rhs: QRoute, root: QRoute? = nil) -> QRoute {
        let root = root ?? findRoot(from: lhs)
        let left:  [QRoute] = QRoute.buildPath(upTo: root.id, from: lhs).map { $0.route }
        let right: [QRoute] = QRoute.buildPath(upTo: root.id, from: rhs).map { $0.route }
        return left.first { right.contains($0) } ?? root
    }
}

fileprivate extension QRoute {
    func pathIfEmpty(_ targetId: QRouteId) -> QRoutePath? {
        return (targetId.isEmpty) ? [] : nil
    }

    func pathIfSelf(_ targetId: QRouteId) -> QRoutePath? {
        return (targetId == self.id) ? [.SELF(self)] : nil
    }

    func pathIfDescendant(_ targetId: QRouteId) -> QRoutePath? {
        guard let discoveredDescendant = self.findDescendant(targetId) else { return nil }
        return QRoute.buildPath(downTo: discoveredDescendant, from: self.id)
    }

    func pathIfAncestor(_ targetId: QRouteId) -> QRoutePath? {
        guard let discoveredAncestor = self.findAncestor(targetId) else { return nil }
        return QRoute.buildPath(upTo: discoveredAncestor.id, from: self)
    }

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
