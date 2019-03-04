
import XCTest
import QRoute

class Captured<T> { var value: T? }

extension XCTestCase {

    func expectationForRoutableCompletion(_ name: String = "") -> (XCTestExpectation, Captured<QRoutable>, QRoutableCompletion) {
        let expect = expectation(description: "routable completion (\(name))")
        let captured = Captured<QRoutable>()
        let completion: QRoutableCompletion = {
            captured.value = $0
            expect.fulfill()
        }
        return(expect, captured, completion)
    }

    func captureRoutableCompletion() -> (Captured<QRoutable>, QRoutableCompletion) {
        let captured = Captured<QRoutable>()
        let completion: QRoutableCompletion = {
            captured.value = $0
        }
        return(captured, completion)
    }
}
