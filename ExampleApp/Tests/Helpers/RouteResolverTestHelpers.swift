
import XCTest

class Captured<T> { var value: T? }

extension XCTestCase {

    func expectationForRoutableCompletion(_ name: String = "") -> (XCTestExpectation, Captured<QTRoutable>, QTRoutableCompletion) {
        let expect = expectation(description: "routable completion (\(name))")
        let captured = Captured<QTRoutable>()
        let completion: QTRoutableCompletion = {
            captured.value = $0
            expect.fulfill()
        }
        return(expect, captured, completion)
    }

    func captureRoutableCompletion() -> (Captured<QTRoutable>, QTRoutableCompletion) {
        let captured = Captured<QTRoutable>()
        let completion: QTRoutableCompletion = {
            captured.value = $0
        }
        return(captured, completion)
    }
}
