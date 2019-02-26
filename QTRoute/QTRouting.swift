
protocol QTRouting {
    func routeTo(_ targetId: QTRouteId, from source: QTRoutable, completion: QTRoutingCompletion?)
    func routeSub(_ targetId: QTRouteId, from source: QTRoutable, completion: QTRoutingCompletion?)
}

typealias QTRoutingCompletion = ()->()
