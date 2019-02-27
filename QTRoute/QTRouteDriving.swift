
protocol QTRouteDriving: class {
    func driveParent(from source: QTRoutable, completion: QTRouteDrivingCompletion?)
    func driveSub(_ targetId: QTRouteId, from source: QTRoutable, completion: QTRouteDrivingCompletion?)
    func driveTo(_ targetId: QTRouteId, from source: QTRoutable, completion: QTRouteDrivingCompletion?)
}

typealias QTRouteDrivingCompletion = (QTRoutable?)->()
