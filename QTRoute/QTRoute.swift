
typealias QTRouteId = String

class QTRoute {
    let id: QTRouteId
    let dependencies: [String]
    var routes: [QTRoute] = []

    weak var parent: QTRoute? = nil

    func route(_ id:QTRouteId) -> QTRoute? {
        return routes.first { $0.id == id }
    }

    var flattened: Set<QTRoute> {
        return Set<QTRoute>( [self] + routes.flatMap { $0.flattened } )
    }

    required init(id:QTRouteId, dependencies: [String], routes: [QTRoute]) {
        self.id = id
        self.dependencies = dependencies
        self.routes = routes.map { $0.applyParent(self) }
    }

    private func applyParent(_ parent: QTRoute) -> Self {
        self.parent = parent
        return self
    }
}

extension QTRoute {

    convenience init(_ id:QTRouteId, dependencies: [String], _ routes: QTRoute...) {
        self.init(id: id, dependencies: dependencies, routes: routes)
    }

    convenience init(_ id:QTRouteId, dependencies: [String]) {
        self.init(id: id, dependencies: dependencies, routes: [])
    }

    convenience init(_ id:QTRouteId, _ routes: QTRoute...) {
        self.init(id: id, dependencies: [], routes: routes)
    }

    convenience init(_ id:QTRouteId) {
        self.init(id: id, dependencies: [], routes: [])
    }

    convenience init(shallowClone route: QTRoute) {
        self.init(id: route.id, dependencies: route.dependencies, routes: [])
        self.parent = nil
    }

    convenience init(deepClone route: QTRoute) {
        let newRoutes: [QTRoute] = route.routes.map { QTRoute(deepClone: $0) }
        self.init(id: route.id, dependencies: route.dependencies, routes: newRoutes)
        self.parent = nil
    }
}

extension QTRoute: Hashable {
    static func == (lhs: QTRoute, rhs: QTRoute) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension QTRoute: CustomDebugStringConvertible {

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

    var debugDescription: String {
        return debugRouteDescription()
    }
}
