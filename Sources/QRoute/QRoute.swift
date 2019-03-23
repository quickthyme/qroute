
public typealias QRouteId = String

public class QRoute: Hashable, CustomDebugStringConvertible {

    public required init(id:QRouteId, dependencies: [String], routes: [QRoute]) {
        self.id = id
        self.dependencies = dependencies
        self.routes = routes.map { $0.applyParent(self) }
    }

    public convenience init(shallowClone route: QRoute) {
        self.init(id: route.id, dependencies: route.dependencies, routes: [])
        self.parent = nil
    }

    public convenience init(deepClone route: QRoute) {
        let newRoutes: [QRoute] = route.routes.map { QRoute(deepClone: $0) }
        self.init(id: route.id, dependencies: route.dependencies, routes: newRoutes)
        self.parent = nil
    }

    public let id: QRouteId
    public let dependencies: [String]
    public var routes: [QRoute] = []

    public weak var parent: QRoute? = nil

    public func route(_ id:QRouteId) -> QRoute? {
        return routes.first { $0.id == id }
    }

    public var flattened: Set<QRoute> {
        return Set<QRoute>( [self] + routes.flatMap { $0.flattened } )
    }

    public func applyParent(_ parent: QRoute) -> Self {
        self.parent = parent
        return self
    }

    public static func == (lhs: QRoute, rhs: QRoute) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public var debugDescription: String {
        return debugRouteDescription()
    }
}

fileprivate extension QRoute {

    func debugRouteDescription() -> String {
        return self.debugRouteDescription("")
    }

    func debugRouteDescription(_ indent: String) -> String {
        var output = "\(indent)\"\(id)\""
        if (!dependencies.isEmpty) {
            output +=
                " (" + dependencies.joined(separator: ", ") + ")"
        }
        if (!routes.isEmpty) {
            output +=
                " {\n"
                + routes.reduce("", { $0 + $1.debugRouteDescription(indent + "    ") })
                + "\(indent)}\n"
        } else {
            output += "\n"
        }
        return output
    }
}
