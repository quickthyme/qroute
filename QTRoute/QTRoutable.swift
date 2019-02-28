
protocol QTRoutable: class {
    var routeResolver: QTRouteResolving? { get }
}

typealias QTRoutableInput = [String:Any]
typealias QTRoutableCompletion = (QTRoutable?)->()
