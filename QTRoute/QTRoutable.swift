
protocol QTRoutable: class {
    var route: QTRoute { get set }
    var router: QTRouting? { get set }
    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion)
    func routeToParent(completion: @escaping QTRoutableCompletion)
    func routeToSelf(completion: @escaping QTRoutableCompletion)
}

typealias QTRoutableCompletion = (QTRoutable)->()
