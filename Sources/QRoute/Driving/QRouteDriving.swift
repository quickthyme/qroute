
public protocol QRouteDriving: class {

    func driveParent(from source: QRoutable,
                     input: QRoutableInput?,
                     animated:Bool,
                     completion: QRoutableCompletion?)

    func driveSub(_ targetId: QRouteId,
                  from source: QRoutable,
                  input: QRoutableInput?,
                  animated:Bool,
                  completion: QRoutableCompletion?)

    func driveTo(_ targetId: QRouteId,
                 from source: QRoutable,
                 input: QRoutableInput?,
                 animated:Bool,
                 completion: QRoutableCompletion?)
}
