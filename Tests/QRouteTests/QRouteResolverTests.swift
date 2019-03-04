
import XCTest
import QRoute

class QRouteResolverTests: XCTestCase {

    var subject: QRouteResolver!
    var stubResolvers: StubQResolverActions!
    var mockRoutable: MockQRoutable!
    let route = QRoute("route")

    override func setUp() {
        stubResolvers = StubQResolverActions()
        subject = QRouteResolver(route,
                                  toChild: stubResolvers.ToChild1(),
                                  toParent: stubResolvers.ToParent(),
                                  toSelf: stubResolvers.ToSelf())
        mockRoutable = MockQRoutable(subject)
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

    private class DefaultImplementationResolver: QRouteResolving {
        var route: QRoute = QRoute("A", dependencies: ["number"])
        func resolveRouteToChild(_ route: QRoute, from: QRoutable, input: QRoutableInput,
                                 animated: Bool,
                                 completion: @escaping QRoutableCompletion) { /**/ }
        func resolveRouteToParent(from: QRoutable, input: QRoutableInput,
                                  animated: Bool,
                                  completion: @escaping QRoutableCompletion) { /**/ }
    }
}
