
protocol QTRouting {
    func route(to targetId: QTRouteId, from source: QTRoutable, completion: QTRoutingCompletion?)
    func routeSub(to targetId: QTRouteId, from source: QTRoutable, completion: QTRoutingCompletion?)
}

typealias QTRoutingCompletion = ()->()
