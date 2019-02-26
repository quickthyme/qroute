
typealias QTRoutePath = Array<QTRoutePathNode>

class QTRoutePathNode {
    let direction: Direction
    let route: QTRoute
    init(_ direction: Direction, _ route: QTRoute) {
        self.direction = direction
        self.route = route
    }

    enum Direction {
        case SELF, UP, DOWN
    }
}

extension QTRoutePathNode: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(route)
        hasher.combine(direction)
    }
    static func == (lhs: QTRoutePathNode, rhs: QTRoutePathNode) -> Bool {
        return (
            lhs.route == rhs.route
            && lhs.direction == rhs.direction
        )
    }
}

extension QTRoutePathNode: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<\(type(of: self))> (\(self.direction), \"\(route.id)\")"
    }
}

extension QTRoute {
    func findPath(to targetId: QTRouteId) -> QTRoutePath {
        guard (targetId != "") else { return [] }
        if (targetId == self.id) {
            return [QTRoutePathNode(.SELF, self)]
        } else if let discoveredChild = self.findDescendent(targetId) {
            return QTRoute.buildPath(downTo: discoveredChild, from: self.id)
        } else if let discoveredParent = self.findAncestor(targetId) {
            return QTRoute.buildPath(upTo: discoveredParent.id, from: self)
        }
        return findComplexPath(to: targetId)
    }

    private func findComplexPath(to targetId: QTRouteId) -> QTRoutePath {
        let root = self.findRoot()
        guard let target = root.findDescendent(targetId) else { return [] }
        let ancestor = self.findLowestCommonAncestor(otherRoute: target, root: root)
        return QTRoute.buildPath(to: target, from: self, byWayOf: ancestor)
    }

    func findDescendent(_ id: QTRouteId) -> QTRoute? {
        return QTRoute.findDescendent(id, from: self)
    }

    static func findDescendent(_ id: QTRouteId, from route: QTRoute) -> QTRoute? {
        return route.route(id)
            ?? route.routes.compactMap { $0.findDescendent(id) } .first
    }

    func findAncestor(_ id: QTRouteId) -> QTRoute? {
        return QTRoute.findAncestor(id, from: self)
    }

    static func findAncestor(_ id: QTRouteId, from route:QTRoute) -> QTRoute? {
        guard let parent = route.parent else { return nil }
        return
            (parent.id == id)
                ? parent
                : findAncestor(id, from: parent)
    }

    func findRoot() -> QTRoute {
        return QTRoute.findRoot(from: self)
    }

    static func findRoot(from route:QTRoute) -> QTRoute {
        return (route.parent == nil) ? route : findRoot(from: route.parent!)
    }

    func findLowestCommonAncestor(otherRoute: QTRoute, root: QTRoute? = nil) -> QTRoute {
        return QTRoute.findLowestCommonAncestor(lhs: self, rhs: otherRoute, root: root)
    }

    static func findLowestCommonAncestor(lhs: QTRoute, rhs: QTRoute, root: QTRoute? = nil) -> QTRoute {
        let root = root ?? findRoot(from: lhs)
        let left:  [QTRoute] = QTRoute.buildPath(upTo: root.id, from: lhs).map { $0.route }
        let right: [QTRoute] = QTRoute.buildPath(upTo: root.id, from: rhs).map { $0.route }
        return left.first { right.contains($0) } ?? root
    }

    private static func buildPath(downTo route: QTRoute, from fromId: QTRouteId, currentPath:QTRoutePath = []) -> QTRoutePath {
        if (fromId == route.id) {
            return currentPath
        }
        guard let parent = route.parent else { return [QTRoutePathNode(.DOWN, route)] + currentPath}
        return buildPath(downTo: parent,
                         from: fromId,
                         currentPath: [QTRoutePathNode(.DOWN, route)] + currentPath)
    }

    private static func buildPath(upTo toId: QTRouteId, from: QTRoute, currentPath:QTRoutePath = []) -> QTRoutePath {
        if (toId == from.id) {
            return currentPath
        }
        guard let parent = from.parent else { return currentPath}
        return buildPath(upTo: toId,
                         from: parent,
                         currentPath: currentPath + [QTRoutePathNode(.UP, parent)])
    }

    private static func buildPath(to: QTRoute, from: QTRoute, byWayOf ancestor: QTRoute) -> QTRoutePath {
        let startPath = QTRoute.buildPath(upTo: ancestor.id, from: from)
        let endPath = QTRoute.buildPath(downTo: to, from: ancestor.id)
        return startPath + endPath
    }
}
