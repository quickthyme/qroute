
import QRoute

class MockQRouteDriver: QRouteDriving {

    func reset() {
        timesCalled_driveParent = 0
        valueFor_driveParent_input = nil

        timesCalled_driveSub = 0
        valueFor_driveSub_targetId = nil
        valueFor_driveSub_input = nil

        timesCalled_driveTo = 0
        valueFor_driveTo_targetId = nil
        valueFor_driveTo_input = nil
    }

    var timesCalled_driveParent: Int = 0
    var valueFor_driveParent_input: QRouteResolving.Input?
    var valueFor_driveParent_completion: QRouteResolving.Completion?

    func driveParent(from source: QRoutable, input: QRouteResolving.Input?,
                     animated: Bool,
                     completion: QRouteResolving.Completion?) {
        timesCalled_driveParent += 1
        valueFor_driveParent_input = input
        valueFor_driveParent_completion = completion
    }


    var timesCalled_driveSub: Int = 0
    var valueFor_driveSub_targetId: QRouteId?
    var valueFor_driveSub_input: QRouteResolving.Input?
    var valueFor_driveSub_completion: QRouteResolving.Completion?

    func driveSub(_ targetId: QRouteId, from source: QRoutable, input: QRouteResolving.Input?,
                  animated: Bool,
                  completion: QRouteResolving.Completion?) {
        timesCalled_driveSub += 1
        valueFor_driveSub_targetId = targetId
        valueFor_driveSub_input = input
        valueFor_driveSub_completion = completion
    }


    var timesCalled_driveTo: Int = 0
    var valueFor_driveTo_targetId: QRouteId?
    var valueFor_driveTo_input: QRouteResolving.Input?
    var valueFor_driveTo_completion: QRouteResolving.Completion?

    func driveTo(_ targetId: QRouteId, from source: QRoutable, input: QRouteResolving.Input?,
                 animated: Bool,
                 completion: QRouteResolving.Completion?) {
        timesCalled_driveTo += 1
        valueFor_driveTo_targetId = targetId
        valueFor_driveTo_input = input
        valueFor_driveTo_completion = completion
    }
}
