
public protocol QTRoutable: class {
    var routeInput: QTRoutableInput? { get set }
    var routeResolver: QTRouteResolving? { get }
}

public typealias QTRoutableInput = [String:Any]
public typealias QTRoutableCompletion = (QTRoutable?)->()
