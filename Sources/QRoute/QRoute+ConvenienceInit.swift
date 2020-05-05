public extension QRoute {
    convenience init(_ id:QRouteId, dependencies: [String], _ routes: QRoute...) {
        self.init(id: id, dependencies: dependencies, routes: routes)
    }

    convenience init(_ id:QRouteId, dependencies: [String]) {
        self.init(id: id, dependencies: dependencies, routes: [])
    }

    convenience init(_ id:QRouteId, _ routes: QRoute...) {
        self.init(id: id, dependencies: [], routes: routes)
    }

    convenience init(_ id:QRouteId, _ routes: Set<QRoute>) {
        self.init(id: id, dependencies: [], routes: Array<QRoute>(routes))
    }

    convenience init(_ id:QRouteId) {
        self.init(id: id, dependencies: [], routes: [])
    }
}
