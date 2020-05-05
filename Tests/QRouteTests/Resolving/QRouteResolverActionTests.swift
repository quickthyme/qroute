import XCTest
import QRoute

class QRouteResolverActionTests: XCTestCase {

    var resolver: QRouteResolver!
    var stubActions: StubQResolverActions!
    var mockRoutable: QRoutableMock!
    let route = QRoute("route")

    override func setUp() {
        stubActions = StubQResolverActions()
    }

    func testResolveRouteToChildSwitch() {
        given("ToChildSwitch with 2 actions, no default, and some routes") {
            let route1 = QRoute("route1")
            let route2 = QRoute("route2")
            let subject = QRouteResolver.DefaultAction
                .ToChildSwitch([
                    route1.id: stubActions.ToChild1(),
                    route2.id: stubActions.ToChild2()])

            resolver = QRouteResolver(
                route1,
                toChild: subject,
                toParent: stubActions.ToParent(),
                toSelf: stubActions.ToSelf())
            mockRoutable = QRoutableMock(resolver)

            when("calling resolveRouteToChild for unregistered route") {
                stubActions.reset()
                resolver.resolveRouteToChild(QRoute("route9"),
                                             from: mockRoutable,
                                             input: [:],
                                             animated: false,
                                             completion: {_ in})
                then("it should not call any method") {
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

    func testResolveRouteToChildSwitch_default() {
        given("ToChildSwitch with 2 actions, a default action, and 2 routes") {
            let route1 = QRoute("route1")
            let route2 = QRoute("route2")
            let subject = QRouteResolver.DefaultAction
                .ToChildSwitch([route1.id: stubActions.ToChild1(),
                               route2.id: stubActions.ToChild2()],
                              default: stubActions.ToChild3())

            resolver = QRouteResolver(
                route1,
                toChild: subject,
                toParent: stubActions.ToParent(),
                toSelf: stubActions.ToSelf())
            mockRoutable = QRoutableMock(resolver)

            when("calling resolveRouteToChild for unregistered route") {
                stubActions.reset()
                resolver.resolveRouteToChild(QRoute("route9"),
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
