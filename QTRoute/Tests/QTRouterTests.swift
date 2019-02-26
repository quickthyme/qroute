
import XCTest

class QTRouterTests: XCTestCase {

    var subject: QTRouter!

    override func setUp() {
        subject = QTRouter()
    }

    func testRouteToFrom_nowhere() {
        given("routable for route with no parent or children") {
            let marco = QTRoute("marco")
            let mockRoutable = MockRoutable(route: marco)

            when("trying to route to non-existent route") {
                let expectComplete = expectation(description: "complete")
                subject.routeTo("polo", from: mockRoutable, completion: { expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should not go anywhere") {
                    XCTAssertEqual(mockRoutable.timesCalled_routeToChild, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToSelf, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToParent, 0)
                    XCTAssertEqual(mockRoutable.routeTrail, [])
                    XCTAssertEqual(mockRoutable.route, marco)
                }
            }
        }
    }

    func testRouteToFrom_shallow() {
        given("routes grumpy -> pabst -> sissy") {
            let sissy = QTRoute("sissy")
            let pabst = QTRoute("pabst", sissy)
            let grumpy = QTRoute("grumpy", pabst)

            when("pabst routes to grumpy") {
                let mockRoutable = MockRoutable(route: pabst)
                let expectComplete = expectation(description: "complete")
                subject.routeTo("grumpy", from: mockRoutable, completion: { expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to parent one times landing on 'grumpy'") {
                    XCTAssertEqual(mockRoutable.timesCalled_routeToChild, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToSelf, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToParent, 1)
                    XCTAssertEqual(mockRoutable.routeTrail, [grumpy])
                    XCTAssertEqual(mockRoutable.route, grumpy)
                }
            }

            when("pabst routes to sissy") {
                let mockRoutable = MockRoutable(route: pabst)
                let expectComplete = expectation(description: "complete")
                subject.routeTo("sissy", from: mockRoutable, completion: { expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to child one times landing on sissy") {
                    XCTAssertEqual(mockRoutable.timesCalled_routeToChild, 1)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToSelf, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToParent, 0)
                    XCTAssertEqual(mockRoutable.routeTrail, [sissy])
                    XCTAssertEqual(mockRoutable.route, sissy)
                }
            }

            when("pabst routes to self") {
                let mockRoutable = MockRoutable(route: pabst)
                let expectComplete = expectation(description: "complete")
                subject.routeTo("pabst", from: mockRoutable, completion: { expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to self one times") {
                    XCTAssertEqual(mockRoutable.timesCalled_routeToChild, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToSelf, 1)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToParent, 0)
                    XCTAssertEqual(mockRoutable.routeTrail, [pabst])
                    XCTAssertEqual(mockRoutable.route, pabst)
                }
            }

            when("grumpy routes to sissy") {
                let mockRoutable = MockRoutable(route: grumpy)
                let expectComplete = expectation(description: "complete")
                subject.routeTo("sissy", from: mockRoutable, completion: { expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to child two times landing on 'sissy'") {
                    XCTAssertEqual(mockRoutable.timesCalled_routeToChild, 2)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToSelf, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToParent, 0)
                    XCTAssertEqual(mockRoutable.routeTrail, [pabst, sissy])
                    XCTAssertEqual(mockRoutable.route, sissy)
                }
            }

            when("sissy routes to grumpy") {
                let mockRoutable = MockRoutable(route: sissy)
                let expectComplete = expectation(description: "complete")
                subject.routeTo("grumpy", from: mockRoutable, completion: { expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to parent two times lanfing on 'grumpy'") {
                    XCTAssertEqual(mockRoutable.timesCalled_routeToChild, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToSelf, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToParent, 2)
                    XCTAssertEqual(mockRoutable.routeTrail, [pabst, grumpy])
                    XCTAssertEqual(mockRoutable.route, grumpy)
                }
            }
        }
    }

    func testRouteToFrom_complex() {
        given("MockRoutePlan") {
            let root = MockRoutePlan()
            let toDo = root.route("To-Do")!
            let toDoDetail = toDo.route("To-Do Detail")!
            let toDoEditImage = toDoDetail.route("To-Do Edit Image")!
            let help = root.route("Help")!
            let messageCenter = help.route("Message Center")!

            when("routing 'To-Do Edit Image' to 'Message Center'") {
                let mockRoutable = MockRoutable(route: toDoEditImage)
                let expectComplete = expectation(description: "complete")
                subject.routeTo("Message Center", from: mockRoutable, completion: { expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to parent 3 times and child 2 times landing at 'Message Center'") {
                    XCTAssertEqual(mockRoutable.timesCalled_routeToChild, 2)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToSelf, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToParent, 3)
                    XCTAssertEqual(mockRoutable.routeTrail, [toDoDetail, toDo, root, help, messageCenter])
                    XCTAssertEqual(mockRoutable.route, messageCenter)
                }
            }
        }
    }

    func testRouteSub() {
        given("MockRoutePlan") {
            let root = MockRoutePlan()
            let toDoDetail = root.route("To-Do")!.route("To-Do Detail")!
            let messageCenter = root.route("Help")!.route("Message Center")!

            when("substitute routing 'To-Do Detail' to 'Message Center'") {
                let mockRoutable = MockRoutable(route: toDoDetail)
                let expectComplete = expectation(description: "complete")
                subject.routeSub("Message Center", from: mockRoutable, completion: { expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to child 1 times landing at 'Message Center' clone") {
                    let messageCenterClone = mockRoutable.route
                    XCTAssertEqual(mockRoutable.routeTrail, [messageCenterClone])
                    XCTAssertEqual(mockRoutable.route, messageCenterClone)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToChild, 1)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToSelf, 0)
                    XCTAssertEqual(mockRoutable.timesCalled_routeToParent, 0)
                    with("'Message Center' Clone not the same instance as 'Message Center'") {
                        XCTAssert(messageCenterClone !== messageCenter)
                    }
                    with("'Message Center' Clone parent property set to actual 'To-Do Detail'") {
                        XCTAssertEqual(messageCenterClone.parent, toDoDetail)
                    }
                    with("'To-Do Detail' retaining its original child routes (no ref to 'Message Center')") {
                        XCTAssertEqual(toDoDetail.routes.count, 1)
                        XCTAssertNotNil(toDoDetail.route("To-Do Edit Image"))
                        XCTAssertNil(toDoDetail.route("Message Center"))
                    }

                    when("navigating back") {
                        let expectComplete = expectation(description: "complete")
                        var backResult: QTRoutable? = nil
                        mockRoutable.routeToParent { backResult = $0; expectComplete.fulfill(); }
                        wait(for: [expectComplete], timeout: 0.1)
                        then("it should arrive back at 'To-Do Detail'") {
                            XCTAssertEqual(backResult?.route, toDoDetail)
                        }
                    }

                }
            }
        }
    }
}
