
protocol QTRouteDriving: class {
    func driveParent(from source: QTRoutable, input: QTRouteResolvingInput?, completion: QTRouteDrivingCompletion?)
    func driveSub(_ targetId: QTRouteId, from source: QTRoutable, input: QTRouteResolvingInput?, completion: QTRouteDrivingCompletion?)
    func driveTo(_ targetId: QTRouteId, from source: QTRoutable, input: QTRouteResolvingInput?, completion: QTRouteDrivingCompletion?)
}

typealias QTRouteResolvingInput = [String:Any]
typealias QTRouteDrivingCompletion = (QTRoutable?)->()
