
import XCTest
import QTRoute

class QTRouteResolverActionTests: XCTestCase {

    var resolver: QTRouteResolver!
    var stubActions: StubQTResolverActions!
    var mockRoutable: MockQTRoutable!
    let route = QTRoute("route")

    override func setUp() {
        stubActions = StubQTResolverActions()
    }

    func testResolveRouteToChildKeyed() {
        given("ToChildKeyed with 2 actions, no default, and some routes") {
            let route1 = QTRoute("route1")
            let route2 = QTRoute("route2")
            let subject = QTRouteResolver.DefaultAction
                .ToChildKeyed([
                    route1.id: stubActions.ToChild1(),
                    route2.id: stubActions.ToChild2()])

            resolver = QTRouteResolver(
                route1,
                toChild: subject,
                toParent: stubActions.ToParent(),
                toSelf: stubActions.ToSelf())
            mockRoutable = MockQTRoutable(resolver)

            when("calling resolveRouteToChild for unregistered route") {
                stubActions.reset()
                resolver.resolveRouteToChild(QTRoute("route9"),
                                             from: mockRoutable,
                                             input: [:],
                                             animated: false,
                                             completion: {_ in})
                then("it should not call either method") {
                    XCTAssertFalse(stubActions.didCall_ToChild1)
                    XCTAssertFalse(stubActions.didCall_ToChild2)
                    XCTAssertFalse(stubActions.didCall_ToParent)
                    XCTAssertFalse(stubActions.didCall_ToSelf)
                }
            }

            when("calling resolveRouteToChild for route 1") {
                stubActions.reset()
                resolver.resolveRouteToChild(route1,
                                             from: mockRoutable,
                                             input: [:],
                                             animated: false,
                                             completion: {_ in})
                then("it should use the ToChild1 method") {
                    XCTAssertTrue(stubActions.didCall_ToChild1)
                    XCTAssertFalse(stubActions.didCall_ToChild2)
                    XCTAssertFalse(stubActions.didCall_ToParent)
                    XCTAssertFalse(stubActions.didCall_ToSelf)
                }
            }

            when("calling resolveRouteToChild for route 2") {
                stubActions.reset()
                resolver.resolveRouteToChild(route2,
                                             from: mockRoutable,
                                             input: [:],
                                             animated: false,
                                             completion: {_ in})
                then("it should use the ToChild2 method") {
                    XCTAssertTrue(stubActions.didCall_ToChild2)
                    XCTAssertFalse(stubActions.didCall_ToChild1)
                    XCTAssertFalse(stubActions.didCall_ToParent)
                    XCTAssertFalse(stubActions.didCall_ToSelf)
                }
            }
        }
    }

    func testResolveRouteToChildKeyed_default() {
        given("ToChildKeyed with 2 actions, a default action, and 2 routes") {
            let route1 = QTRoute("route1")
            let route2 = QTRoute("route2")
            let subject = QTRouteResolver.DefaultAction
                .ToChildKeyed([route1.id: stubActions.ToChild1(),
                               route2.id: stubActions.ToChild2()],
                              default: stubActions.ToChild3())

            resolver = QTRouteResolver(
                route1,
                toChild: subject,
                toParent: stubActions.ToParent(),
                toSelf: stubActions.ToSelf())
            mockRoutable = MockQTRoutable(resolver)

            when("calling resolveRouteToChild for unregistered route") {
                stubActions.reset()
                resolver.resolveRouteToChild(QTRoute("route9"),
                                             from: mockRoutable,
                                             input: [:],
                                             animated: false,
                                             completion: {_ in})
                then("it should only call the default route") {
                    XCTAssertTrue(stubActions.didCall_ToChild3)
                    XCTAssertFalse(stubActions.didCall_ToChild1)
                    XCTAssertFalse(stubActions.didCall_ToChild2)
                    XCTAssertFalse(stubActions.didCall_ToParent)
                    XCTAssertFalse(stubActions.didCall_ToSelf)
                }
            }

            when("calling resolveRouteToChild for route 1") {
                stubActions.reset()
                resolver.resolveRouteToChild(route1,
                                             from: mockRoutable,
                                             input: [:],
                                             animated: false,
                                             completion: {_ in})
                then("it should use the ToChild1 method") {
                    XCTAssertTrue(stubActions.didCall_ToChild1)
                    XCTAssertFalse(stubActions.didCall_ToChild2)
                    XCTAssertFalse(stubActions.didCall_ToChild3)
                    XCTAssertFalse(stubActions.didCall_ToParent)
                    XCTAssertFalse(stubActions.didCall_ToSelf)
                }
            }

            when("calling resolveRouteToChild for route 2") {
                stubActions.reset()
                resolver.resolveRouteToChild(route2,
                                             from: mockRoutable,
                                             input: [:],
                                             animated: false,
                                             completion: {_ in})
                then("it should use the ToChild2 method") {
                    XCTAssertTrue(stubActions.didCall_ToChild2)
                    XCTAssertFalse(stubActions.didCall_ToChild1)
                    XCTAssertFalse(stubActions.didCall_ToChild3)
                    XCTAssertFalse(stubActions.didCall_ToParent)
                    XCTAssertFalse(stubActions.didCall_ToSelf)
                }
            }
        }
    }
}
