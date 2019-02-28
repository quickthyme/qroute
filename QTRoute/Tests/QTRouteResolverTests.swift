
import XCTest

class QTRouteResolverTests: XCTestCase {

    var subject: QTRouteResolver!
    var mockResolvers: MockResolvers!
    var mockRoutable: MockRoutable!
    let route = QTRoute("route")

    override func setUp() {
        mockResolvers = MockResolvers()
        subject = QTRouteResolver(route,
                                  toChild: mockResolvers.ToChild(),
                                  toParent: mockResolvers.ToParent(),
                                  toSelf: mockResolvers.ToSelf())
        mockRoutable = MockRoutable(routeResolver: subject)
    }

    func testResolveRouteToParent() {
        when("calling resolveRouteToParent") {
            subject.resolveRouteToParent(from: mockRoutable, input: [:], completion: {_ in})
            then("it should use the ToParent method") {
                XCTAssertTrue(mockResolvers.didCall_ToParent)
            }
        }
    }

    func testResolveRouteToChild() {
        when("calling resolveRouteToChild") {
            subject.resolveRouteToChild(route, from: mockRoutable, input: [:], completion: {_ in})
            then("it should use the ToChild method") {
                XCTAssertTrue(mockResolvers.didCall_ToChild)
            }
        }
    }

    func testResolveRouteToSelf() {
        when("calling resolveRouteToSelf") {
            subject.resolveRouteToSelf(from: mockRoutable, input: [:], completion: {_ in})
            then("it should use the ToSelf method") {
                XCTAssertTrue(mockResolvers.didCall_ToSelf)
            }
        }
    }
}

extension QTRouteResolverTests {
    class MockResolvers {

        var didCall_ToChild = false
        func ToChild() -> QTRouteResolver.ToChild {
            return { [weak self] route, from, input, completion in
                self?.didCall_ToChild = true
            }
        }

        var didCall_ToParent = false
        func ToParent() -> QTRouteResolver.ToParent {
            return { [weak self] from, input, completion in
                self?.didCall_ToParent = true
            }
        }

        var didCall_ToSelf = false
        func ToSelf() -> QTRouteResolver.ToSelf {
            return { [weak self] from, input, completion in
                self?.didCall_ToSelf = true
            }
        }
    }
}
