
protocol QTRouteDriving: class {
    func driveParent(from source: QTRoutable, input: QTRoutableInput?, completion: QTRoutableCompletion?)
    func driveSub(_ targetId: QTRouteId, from source: QTRoutable, input: QTRoutableInput?, completion: QTRoutableCompletion?)
    func driveTo(_ targetId: QTRouteId, from source: QTRoutable, input: QTRoutableInput?, completion: QTRoutableCompletion?)
}
