
import XCTest

class QTRouteTests: XCTestCase {

    func testRouteStructure() {

        given("routePlan") {
            let routePlanRoot = MockRoutePlan()

            with("id 'Root'") {
                XCTAssertEqual(routePlanRoot.id, "Root")
            }
            with("4 child routes") {
                let rootRoutes = routePlanRoot.routes
                XCTAssertEqual(rootRoutes.count, 4)
                with("parent properties set") {
                    for route in rootRoutes {
                        XCTAssertEqual(route.parent, routePlanRoot)
                    }
                }

                with("root route 'Log')") {
                    let route = routePlanRoot.route("Log")!
                    with("1 child route: 'Log Entry Detail'") {
                        XCTAssertEqual(route.routes.count, 1)
                        let child = route.route("Log Entry Detail")!
                        with("2 runtime dependencies (id, name)") {
                            let deps = child.dependencies
                            XCTAssertNotNil(deps.first {$0 == "logId" })
                            XCTAssertNotNil(deps.first {$0 == "logName" })
                        }
                        with("parent property set") {
                            XCTAssertEqual(child.parent, route)
                        }
                    }
                }

                with("root route 'To-Do')") {
                    let route = routePlanRoot.route("To-Do")!
                    with("1 child route: 'To-Do Detail'") {
                        XCTAssertEqual(route.routes.count, 1)
                        let toDoDetail = route.route("To-Do Detail")!
                        with("1 runtime dependency (id)") {
                            let deps = toDoDetail.dependencies
                            XCTAssertNotNil(deps.first {$0 == "todoId" })
                        }
                        with("parent property set") {
                            XCTAssertEqual(toDoDetail.parent, route)
                        }
                        with("1 child route: 'To-Do Edit Image'") {
                            XCTAssertEqual(toDoDetail.routes.count, 1)
                            XCTAssertNotNil(toDoDetail.route("To-Do Edit Image"))
                        }
                    }
                }

                with("root route 'Settings')") {
                    let route = routePlanRoot.route("Settings")!
                    with("2 child routes: ['Profile Settings','Payment Settings'") {
                        XCTAssertEqual(route.routes.count, 2)
                        let child1 = route.route("Profile Settings")!
                        let child2 = route.route("Payment Settings")!
                        with("no runtime dependencies") {
                            XCTAssertEqual(child1.dependencies.count, 0)
                            XCTAssertEqual(child2.dependencies.count, 0)
                        }
                        with("parent properties set") {
                            XCTAssertEqual(child1.parent, route)
                            XCTAssertEqual(child2.parent, route)
                        }
                    }
                }

                with("root route 'Help')") {
                    let route = routePlanRoot.route("Help")!
                    with("2 child routes: ['Contact Us','Message Center'") {
                        XCTAssertEqual(route.routes.count, 2)
                        let child1 = route.route("Contact Us")!
                        let child2 = route.route("Message Center")!
                        with("no runtime dependencies") {
                            XCTAssertEqual(child1.dependencies.count, 0)
                            XCTAssertEqual(child2.dependencies.count, 0)
                        }
                        with("parent properties set") {
                            XCTAssertEqual(child1.parent, route)
                            XCTAssertEqual(child2.parent, route)
                        }
                    }
                }
            }
        }
    }

    func testDebugDescription() {
        given("routePlan") {
            let routePlanRoot = MockRoutePlan()
            when("debugDescription called") {
//                print(routePlanRoot)
                let desc = routePlanRoot.debugDescription
                then("the output should match the expected length") {
                    XCTAssertEqual(desc.lengthOfBytes(using: .utf8), 310)
                }
            }
        }
    }

    func testHashable() {
        given("routePlan") {
            let routePlanRoot = MockRoutePlan()
            when("the root routes are added to a set") {
                let result = Set<QTRoute>(routePlanRoot.routes)
                then("it should be able to retrieve all four routes") {
                    XCTAssertEqual(result.count, 4)
                    XCTAssertNotNil(result.first{ $0.id == "Log" })
                    XCTAssertNotNil(result.first{ $0.id == "To-Do" })
                    XCTAssertNotNil(result.first{ $0.id == "Settings" })
                    XCTAssertNotNil(result.first{ $0.id == "Help" })
                }
            }
        }
    }

    func testFlattened() {
        given("routePlan") {
            let routePlanRoot = MockRoutePlan()
            when("the root routes are flattened") {
                let flats = routePlanRoot.flattened
                then("it should contain all the routes") {
                    XCTAssertEqual(flats.count, 12)
                }
            }
        }
    }

    func testShallowClone() {
        given("route from routePlan") {
            let routePlanRoot = MockRoutePlan()
            let route = routePlanRoot.route("To-Do")!.route("To-Do Detail")!
            when("shallow cloning") {
                let result = QTRoute(shallowClone: route)
                then("it should not be the same object") {
                    XCTAssert(result !== route)
                }
                then("it should copy the id and runtime dependencies") {
                    XCTAssertEqual(result.id, "To-Do Detail")
                    XCTAssertNotNil(result.dependencies.first { $0 == "todoId" })
                }
                with("parent set to nil") {
                    XCTAssertNil(result.parent)
                }
                with("routes set to empty") {
                    XCTAssertEqual(result.routes, [])
                }
            }
        }
    }

    func testDeepClone() {
        given("route from routePlan") {
            let routePlanRoot = MockRoutePlan()
            let route = routePlanRoot.route("To-Do")!
            when("deep cloning") {
                let result = QTRoute(deepClone: route)
                then("it should not be the same object") {
                    XCTAssert(result !== route)
                }
                then("it should copy the id and runtime dependencies") {
                    XCTAssertEqual(result.id, "To-Do")
                }
                with("parent set to nil") {
                    XCTAssertNil(result.parent)
                }
                with("child routes deeply cloned") {
                    let child1 = route.route("To-Do Detail")
                    let child2 = child1?.route("To-Do Edit Image")
                    let childClone1 = result.route("To-Do Detail")
                    let childClone2 = childClone1?.route("To-Do Edit Image")
                    XCTAssertNotNil(childClone1)
                    XCTAssertNotNil(childClone1)
                    XCTAssert(childClone1 !== child1)
                    XCTAssert(childClone2 !== child2)
                    with("runtime dependencies set") {
                        XCTAssertNotNil(childClone1?.dependencies.first { $0 == "todoId" })
                    }
                    with("parent set to parent") {
                        XCTAssertEqual(childClone1?.parent, result)
                        XCTAssertEqual(childClone2?.parent, childClone1)
                    }
                }
            }
        }
    }
}

