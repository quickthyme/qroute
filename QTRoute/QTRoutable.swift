
protocol QTRoutable: class {
    var route: QTRoute? { get set }
    var router: QTRouting? { get set }

    // required
    func routeToChild(_ route: QTRoute, completion: @escaping QTRoutableCompletion)
    func routeToParent(completion: @escaping QTRoutableCompletion)

    // optional
    func routeToSelf(completion: @escaping QTRoutableCompletion)
}

extension QTRoutable {
    func routeToSelf(completion: @escaping QTRoutableCompletion) {
        completion(self)
    }
}

typealias QTRoutableCompletion = (QTRoutable?)->()
