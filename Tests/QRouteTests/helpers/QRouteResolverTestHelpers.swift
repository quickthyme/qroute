import XCTest
import QRoute

class Captured<T> { var value: T? }

extension XCTestCase {

    func captureRoutableCompletion() -> (Captured<QRoutable>, QRouteResolving.Completion) {
        let captured = Captured<QRoutable>()
        let completion: QRouteResolving.Completion = {
            captured.value = $0
        }
        return(captured, completion)
    }
}
