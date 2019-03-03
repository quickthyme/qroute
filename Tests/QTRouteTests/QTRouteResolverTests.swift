
import XCTest
import QTRoute

class QTRouteResolverTests: XCTestCase {

    var subject: QTRouteResolver!
    var stubResolvers: StubQTResolverActions!
    var mockRoutable: MockQTRoutable!
    let route = QTRoute("route")

    override func setUp() {
        stubResolvers = StubQTResolverActions()
        subject = QTRouteResolver(route,
                                  toChild: stubResolvers.ToChild1(),
                                  toParent: stubResolvers.ToParent(),
                                  toSelf: stubResolvers.ToSelf())
        mockRoutable = MockQTRoutable(subject)
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
                XCTAssertTrue(stubResolvers.didCall_ToChild1)
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

    func testResolveRouteToSelf_defaultImplementation() {
        given("subject inherits default implementation") {
            let defaultImpl = DefaultImplementationResolver()
            mockRoutable.routeResolver = defaultImpl

            when("calling resolveRouteToSelf") {
                let (captured, comletion) = captureRoutableCompletion()

                defaultImpl.resolveRouteToSelf(from: mockRoutable,
                                               input: ["number":9],
                                               animated: false,
                                               completion: comletion)

                then("it should call completion passing the soure routable with merged dependencies") {
                    XCTAssert(captured.value === mockRoutable)
                    XCTAssertEqual(captured.value?.routeInput?["number"] as? Int, 9)
                }
            }
        }
    }

    private class DefaultImplementationResolver: QTRouteResolving {
        var route: QTRoute = QTRoute("A", dependencies: ["number"])
        func resolveRouteToChild(_ route: QTRoute, from: QTRoutable, input: QTRoutableInput,
                                 animated: Bool,
                                 completion: @escaping QTRoutableCompletion) { /**/ }
        func resolveRouteToParent(from: QTRoutable, input: QTRoutableInput,
                                  animated: Bool,
                                  completion: @escaping QTRoutableCompletion) { /**/ }
    }
}
