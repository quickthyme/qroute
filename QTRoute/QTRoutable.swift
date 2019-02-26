
protocol QTRoutable {
    var route: QTRoute { get set }
    func routeToChild(_ route: QTRoute, completion: QTRoutableCompletion)
    func routeToParent(completion: QTRoutableCompletion)
    func routeToSelf(completion: QTRoutableCompletion)
}

typealias QTRoutableCompletion = (QTRoutable)->()
