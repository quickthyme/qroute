public protocol QRouteDriving: class {

    func driveParent(from source: QRoutable,
                     input: QRouteResolving.Input?,
                     animated:Bool,
                     completion: QRouteResolving.Completion?)

    func driveSub(_ targetId: QRouteId,
                  from source: QRoutable,
                  input: QRouteResolving.Input?,
                  animated:Bool,
                  completion: QRouteResolving.Completion?)

    func driveTo(_ targetId: QRouteId,
                 from source: QRoutable,
                 input: QRouteResolving.Input?,
                 animated:Bool,
                 completion: QRouteResolving.Completion?)
}
