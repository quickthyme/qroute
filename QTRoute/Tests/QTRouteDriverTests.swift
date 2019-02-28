
import XCTest

class QTRouteDriverTests: XCTestCase {

    var subject: QTRouteDriver!

    override func setUp() {
        subject = QTRouteDriver()
    }

    func testRouteToFrom_nowhere() {
        given("routable for route with no parent or children") {
            let marco = QTRoute("marco")
            let mockRouteResolver = MockRouteResolver(marco)
            let mockRoutable = MockRoutable(routeResolver: mockRouteResolver)

            when("trying to route to non-existent route") {
                let expectComplete = expectation(description: "complete")
                var finalResolver: MockRouteResolver? = mockRouteResolver
                subject.driveTo("polo", from: mockRoutable, input: nil, completion: {
                    finalResolver = $0?.routeResolver as? MockRouteResolver
                    expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should not go anywhere") {
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToChild, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToSelf, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToParent, 0)
                    XCTAssertEqual(finalResolver?.routeTrail, [])
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
                let mockRouteResolver = MockRouteResolver(pabst)
                let mockRoutable = MockRoutable(routeResolver: mockRouteResolver)
                let expectComplete = expectation(description: "complete")
                var finalResolver: MockRouteResolver? = mockRouteResolver
                subject.driveTo("grumpy", from: mockRoutable, input: nil, completion: {
                    finalResolver = $0?.routeResolver as? MockRouteResolver
                    expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to parent one times landing on 'grumpy'") {
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToChild, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToSelf, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToParent, 1)
                    XCTAssertEqual(finalResolver?.routeTrail, [grumpy])
                }
            }

            when("pabst routes to sissy") {
                let mockRouteResolver = MockRouteResolver(pabst)
                let mockRoutable = MockRoutable(routeResolver: mockRouteResolver)
                let expectComplete = expectation(description: "complete")
                var finalResolver: MockRouteResolver? = mockRouteResolver
                subject.driveTo("sissy", from: mockRoutable, input: nil, completion: {
                    finalResolver = $0?.routeResolver as? MockRouteResolver
                    expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to child one times landing on sissy") {
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToChild, 1)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToSelf, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToParent, 0)
                    XCTAssertEqual(finalResolver?.routeTrail, [sissy])
                }
            }

            when("pabst routes to self") {
                let mockRouteResolver = MockRouteResolver(pabst)
                let mockRoutable = MockRoutable(routeResolver: mockRouteResolver)
                let expectComplete = expectation(description: "complete")
                var finalResolver: MockRouteResolver? = mockRouteResolver
                subject.driveTo("pabst", from: mockRoutable, input: nil, completion: {
                    finalResolver = $0?.routeResolver as? MockRouteResolver
                    expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to self one times") {
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToChild, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToSelf, 1)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToParent, 0)
                    XCTAssertEqual(finalResolver?.routeTrail, [pabst])
                }
            }

            when("grumpy routes to sissy") {
                let mockRouteResolver = MockRouteResolver(grumpy)
                let mockRoutable = MockRoutable(routeResolver: mockRouteResolver)
                let expectComplete = expectation(description: "complete")
                var finalResolver: MockRouteResolver? = mockRouteResolver
                subject.driveTo("sissy", from: mockRoutable, input: nil, completion: {
                    finalResolver = $0?.routeResolver as? MockRouteResolver
                    expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to child two times landing on 'sissy'") {
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToChild, 2)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToSelf, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToParent, 0)
                    XCTAssertEqual(finalResolver?.routeTrail, [pabst, sissy])
                    XCTAssertEqual(finalResolver?.route, sissy)
                }
            }

            when("sissy routes to grumpy") {
                let mockRouteResolver = MockRouteResolver(sissy)
                let mockRoutable = MockRoutable(routeResolver: mockRouteResolver)
                let expectComplete = expectation(description: "complete")
                var finalResolver: MockRouteResolver? = mockRouteResolver
                subject.driveTo("grumpy", from: mockRoutable, input: nil, completion: {
                    finalResolver = $0?.routeResolver as? MockRouteResolver
                    expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to parent two times landing on 'grumpy'") {
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToChild, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToSelf, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToParent, 2)
                    XCTAssertEqual(finalResolver?.routeTrail, [pabst, grumpy])
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
                let mockRouteResolver = MockRouteResolver(toDoEditImage)
                let mockRoutable = MockRoutable(routeResolver: mockRouteResolver)
                let expectComplete = expectation(description: "complete")
                var finalResolver: MockRouteResolver? = mockRouteResolver
                subject.driveTo("Message Center", from: mockRoutable, input: nil, completion: {
                    finalResolver = $0?.routeResolver as? MockRouteResolver
                    expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to parent 3 times and child 2 times landing at 'Message Center'") {
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToChild, 2)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToSelf, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToParent, 3)
                    XCTAssertEqual(finalResolver?.routeTrail, [toDoDetail, toDo, root, help, messageCenter])
                }
            }
        }
    }

    func testRouteSub() {
        given("MockRoutePlan") {
            let root = MockRoutePlan()
            let toDo = root.route("To-Do")!
            let toDoDetail = toDo.route("To-Do Detail")!
            let messageCenter = root.route("Help")!.route("Message Center")!

            when("substitute routing 'To-Do Detail' to 'Message Center'") {
                let mockRouteResolver = MockRouteResolver(toDoDetail)
                let mockRoutable = MockRoutable(routeResolver: mockRouteResolver)
                let expectComplete = expectation(description: "complete")
                var landingRoutable: MockRoutable?
                var finalResolver: MockRouteResolver? = mockRouteResolver
                subject.driveSub("Message Center", from: mockRoutable, input: nil,
                                 completion: {
                                    landingRoutable = $0 as? MockRoutable
                                    finalResolver = $0?.routeResolver as? MockRouteResolver
                                    expectComplete.fulfill() })
                wait(for: [expectComplete], timeout: 0.1)
                then("it should have routed to child 1 times landing at 'Message Center' clone") {
                    let messageCenterClone = finalResolver!.route
                    XCTAssertEqual(finalResolver?.routeTrail, [messageCenterClone])
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToChild, 1)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToSelf, 0)
                    XCTAssertEqual(finalResolver?.timesCalled_resolveRouteToParent, 0)
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
                    with("back trail following the original plan") {
                        let foundPath = messageCenterClone.findPath(to: "Root")
                        let expectedPath: [QTRoutePathNode] = [.UP(toDoDetail),
                                                               .UP(toDo),
                                                               .UP(root)]
                        XCTAssertEqual(foundPath, expectedPath)
                    }
                    when("resolving to parent") {
                        let expectComplete = expectation(description: "complete")
                        var backResult: QTRoutable? = nil
                        subject.driveParent(from: landingRoutable!, input: nil) { backResult = $0; expectComplete.fulfill(); }
                        wait(for: [expectComplete], timeout: 0.1)
                        then("it should arrive back at 'To-Do Detail'") {
                            XCTAssertEqual(backResult?.routeResolver?.route, toDoDetail)
                        }
                    }
                }
            }
        }
    }
}
