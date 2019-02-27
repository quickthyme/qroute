
protocol QTRoutable: class {
    var route: QTRoute? { get set }
    var routeResolver: QTRouteResolving? { get set }
}

typealias QTRoutableCompletion = (QTRoutable?)->()
