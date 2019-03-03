
public typealias QTRouteId = String

public class QTRoute: Hashable, CustomDebugStringConvertible {

    public let id: QTRouteId
    public let dependencies: [String]
    public var routes: [QTRoute] = []

    public weak var parent: QTRoute? = nil

    public func route(_ id:QTRouteId) -> QTRoute? {
        return routes.first { $0.id == id }
    }

    public var flattened: Set<QTRoute> {
        return Set<QTRoute>( [self] + routes.flatMap { $0.flattened } )
    }

    public func applyParent(_ parent: QTRoute) -> Self {
        self.parent = parent
        return self
    }

    public static func == (lhs: QTRoute, rhs: QTRoute) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public var debugDescription: String {
        return debugRouteDescription()
    }

    public required init(id:QTRouteId, dependencies: [String], routes: [QTRoute]) {
        self.id = id
        self.dependencies = dependencies
        self.routes = routes.map { $0.applyParent(self) }
    }

    public convenience init(_ id:QTRouteId, dependencies: [String], _ routes: QTRoute...) {
        self.init(id: id, dependencies: dependencies, routes: routes)
    }

    public convenience init(_ id:QTRouteId, dependencies: [String]) {
        self.init(id: id, dependencies: dependencies, routes: [])
    }

    public convenience init(_ id:QTRouteId, _ routes: QTRoute...) {
        self.init(id: id, dependencies: [], routes: routes)
    }

    public convenience init(_ id:QTRouteId) {
        self.init(id: id, dependencies: [], routes: [])
    }

    public convenience init(shallowClone route: QTRoute) {
        self.init(id: route.id, dependencies: route.dependencies, routes: [])
        self.parent = nil
    }

    public convenience init(deepClone route: QTRoute) {
        let newRoutes: [QTRoute] = route.routes.map { QTRoute(deepClone: $0) }
        self.init(id: route.id, dependencies: route.dependencies, routes: newRoutes)
        self.parent = nil
    }
}

fileprivate extension QTRoute {

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
