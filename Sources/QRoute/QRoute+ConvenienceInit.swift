
public extension QRoute {
    public convenience init(_ id:QRouteId, dependencies: [String], _ routes: QRoute...) {
        self.init(id: id, dependencies: dependencies, routes: routes)
    }

    public convenience init(_ id:QRouteId, dependencies: [String]) {
        self.init(id: id, dependencies: dependencies, routes: [])
    }

    public convenience init(_ id:QRouteId, _ routes: QRoute...) {
        self.init(id: id, dependencies: [], routes: routes)
    }

    public convenience init(_ id:QRouteId, _ routes: Set<QRoute>) {
        self.init(id: id, dependencies: [], routes: Array<QRoute>(routes))
    }

    public convenience init(_ id:QRouteId) {
        self.init(id: id, dependencies: [], routes: [])
    }

}
