
public protocol QRoutable: class {
    var routeInput: QRoutableInput? { get set }
    var routeResolver: QRouteResolving? { get }
}

public typealias QRoutableInput = [String:Any]
public typealias QRoutableCompletion = (QRoutable?)->()
