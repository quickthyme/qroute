
protocol QTRouteDriving: class {

    func driveParent(from source: QTRoutable,
                     input: QTRoutableInput?,
                     animated:Bool,
                     completion: QTRoutableCompletion?)

    func driveSub(_ targetId: QTRouteId,
                  from source: QTRoutable,
                  input: QTRoutableInput?,
                  animated:Bool,
                  completion: QTRoutableCompletion?)

    func driveTo(_ targetId: QTRouteId,
                 from source: QTRoutable,
                 input: QTRoutableInput?,
                 animated:Bool,
                 completion: QTRoutableCompletion?)
}
