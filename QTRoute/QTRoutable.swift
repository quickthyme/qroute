
protocol QTRoutable: class {
    var routeInput: QTRoutableInput? { get set }
    var routeResolver: QTRouteResolving? { get }
}

typealias QTRoutableInput = [String:Any]
typealias QTRoutableCompletion = (QTRoutable?)->()
