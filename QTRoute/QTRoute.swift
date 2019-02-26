
typealias QTRouteId = String

class QTRoute {
    let id: QTRouteId
    let runtimeDependencies: [AnyHashable:Any.Type]
    var routes: [QTRoute] = []

    weak var parent: QTRoute? = nil

    func route(_ id:QTRouteId) -> QTRoute? {
        return routes.first { $0.id == id }
    }

    private func applyParent(_ parent: QTRoute) -> Self {
        self.parent = parent
        return self
    }

    required init(id:QTRouteId, runtimeDependencies: [AnyHashable:Any.Type], routes: [QTRoute]) {
        self.id = id
        self.runtimeDependencies = runtimeDependencies
        self.routes = routes.map { $0.applyParent(self) }
    }
}

extension QTRoute {

    convenience init(_ id:QTRouteId, runtimeDependencies: [AnyHashable:Any.Type], _ routes: QTRoute...) {
        self.init(id: id, runtimeDependencies: runtimeDependencies, routes: routes)
    }

    convenience init(_ id:QTRouteId, runtimeDependencies: [AnyHashable:Any.Type]) {
        self.init(id: id, runtimeDependencies: runtimeDependencies, routes: [])
    }

    convenience init(_ id:QTRouteId, _ routes: QTRoute...) {
        self.init(id: id, runtimeDependencies: [:], routes: routes)
    }

    convenience init(_ id:QTRouteId) {
        self.init(id: id, runtimeDependencies: [:], routes: [])
    }

    convenience init(shallowClone route: QTRoute) {
        self.init(id: route.id, runtimeDependencies: route.runtimeDependencies, routes: [])
        self.parent = nil
    }

    convenience init(deepClone route: QTRoute) {
        let newRoutes: [QTRoute] = route.routes.map { QTRoute(deepClone: $0) }
        self.init(id: route.id, runtimeDependencies: route.runtimeDependencies, routes: newRoutes)
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
        if (!runtimeDependencies.isEmpty) {
            output +=
                " ("
                + runtimeDependencies
                    .map { "\($0.key): \($0.value)" }
                    .joined(separator: ", ")
                + ")"
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
