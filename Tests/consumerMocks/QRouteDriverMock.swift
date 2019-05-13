import QRoute

public class QRouteDriverMock: QRouteTestVerifier, QRouteDriving {

    public func driveParent(from source: QRoutable, input: QRouteResolving.Input?,
                     animated: Bool,
                     completion: QRouteResolving.Completion?) {
        record("driveParent()",
               ("from", source),
               ("input", input),
               ("animated", animated),
               ("completion", completion))
    }


    public func driveSub(_ targetId: QRouteId, from source: QRoutable, input: QRouteResolving.Input?,
                  animated: Bool,
                  completion: QRouteResolving.Completion?) {
        record("driveSub()",
               ("targetId", targetId),
               ("from", source),
               ("input", input),
               ("animated", animated),
               ("completion", completion))
    }

    public func driveTo(_ targetId: QRouteId, from source: QRoutable, input: QRouteResolving.Input?,
                 animated: Bool,
                 completion: QRouteResolving.Completion?) {
        record("driveTo()",
               ("targetId", targetId),
               ("from", source),
               ("input", input),
               ("animated", animated),
               ("completion", completion))
    }
}
