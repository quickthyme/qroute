
class MockRouteDriver: QTRouteDriving {

    func reset() {
        timesCalled_driveParent = 0
        timesCalled_driveSub = 0
        valueFor_driveSub_targetId = nil
        timesCalled_driveTo = 0
        valueFor_driveTo_targetId = nil
    }

    var timesCalled_driveParent: Int = 0
    var valueFor_driveParent_input: QTRoutableInput?
    var valueFor_driveParent_completion: QTRoutableCompletion?

    func driveParent(from source: QTRoutable, input: QTRoutableInput?, completion: QTRoutableCompletion?) {
        timesCalled_driveParent += 1
        valueFor_driveParent_input = input
        valueFor_driveParent_completion = completion
    }


    var timesCalled_driveSub: Int = 0
    var valueFor_driveSub_targetId: QTRouteId?
    var valueFor_driveSub_input: QTRoutableInput?
    var valueFor_driveSub_completion: QTRoutableCompletion?

    func driveSub(_ targetId: QTRouteId, from source: QTRoutable, input: QTRoutableInput?, completion: QTRoutableCompletion?) {
        timesCalled_driveSub += 1
        valueFor_driveSub_targetId = targetId
        valueFor_driveSub_input = input
        valueFor_driveSub_completion = completion
    }


    var timesCalled_driveTo: Int = 0
    var valueFor_driveTo_targetId: QTRouteId?
    var valueFor_driveTo_input: QTRoutableInput?
    var valueFor_driveTo_completion: QTRoutableCompletion?

    func driveTo(_ targetId: QTRouteId, from source: QTRoutable, input: QTRoutableInput?, completion: QTRoutableCompletion?) {
        timesCalled_driveTo += 1
        valueFor_driveTo_targetId = targetId
        valueFor_driveTo_input = input
        valueFor_driveTo_completion = completion
    }
}
