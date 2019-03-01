
import XCTest

class QTRouteResolverTests: XCTestCase {

    var subject: QTRouteResolver!
    var stubResolvers: StubResolvers!
    var mockRoutable: MockRoutable!
    let route = QTRoute("route")

    override func setUp() {
        stubResolvers = StubResolvers()
        subject = QTRouteResolver(route,
                                  toChild: stubResolvers.ToChild(),
                                  toParent: stubResolvers.ToParent(),
                                  toSelf: stubResolvers.ToSelf())
        mockRoutable = MockRoutable(subject)
    }

    func testResolveRouteToParent() {
        when("calling resolveRouteToParent") {
            subject.resolveRouteToParent(from: mockRoutable,
                                         input: [:],
                                         animated: false,
                                         completion: {_ in})
            then("it should use the ToParent method") {
                XCTAssertTrue(stubResolvers.didCall_ToParent)
            }
        }
    }

    func testResolveRouteToChild() {
        when("calling resolveRouteToChild") {
            subject.resolveRouteToChild(route,
                                        from: mockRoutable,
                                        input: [:],
                                        animated: false,
                                        completion: {_ in})
            then("it should use the ToChild method") {
                XCTAssertTrue(stubResolvers.didCall_ToChild)
            }
        }
    }

    func testResolveRouteToSelf() {
        when("calling resolveRouteToSelf") {
            subject.resolveRouteToSelf(from: mockRoutable,
                                       input: [:],
                                       animated: false,
                                       completion: {_ in})
            then("it should use the ToSelf method") {
                XCTAssertTrue(stubResolvers.didCall_ToSelf)
            }
        }
    }
}
