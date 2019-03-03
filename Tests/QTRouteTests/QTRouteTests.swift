
import XCTest
import QTRoute

class QTRouteTests: XCTestCase {

    func testRouteStructure() {

        given("routePlan") {
            let routePlanRoot = MockQTRoutePlan()

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

                with("root route 'Alpha')") {
                    XCTAssertNotNil(routePlanRoot.route("Alpha"))
                }

                with("root route 'Bravo')") {
                    let route = routePlanRoot.route("Bravo")!
                    with("1 child route: 'BravoOne'") {
                        XCTAssertEqual(route.routes.count, 1)
                        let bravoOne = route.route("BravoOne")!
                        with("1 runtime dependency (id)") {
                            let deps = bravoOne.dependencies
                            XCTAssertNotNil(deps.first {$0 == "bravoScoreIndex" })
                        }
                        with("parent property set") {
                            XCTAssertEqual(bravoOne.parent, route)
                        }
                        with("1 child route: 'BravoOneAlpha'") {
                            XCTAssertEqual(bravoOne.routes.count, 1)
                            XCTAssertNotNil(bravoOne.route("BravoOneAlpha"))
                        }
                    }
                }

                with("root route 'Charlie')") {
                    let route = routePlanRoot.route("Charlie")!
                    with("2 child routes: ['CharlieOne','CharlieTwo'") {
                        XCTAssertEqual(route.routes.count, 2)
                        let child1 = route.route("CharlieOne")!
                        let child2 = route.route("CharlieTwo")!
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

                with("root route 'Zach')") {
                    let route = routePlanRoot.route("Zach")!
                    with("2 child routes: ['ZachOne','ZachTwo'") {
                        XCTAssertEqual(route.routes.count, 2)
                        let child1 = route.route("ZachOne")!
                        let child2 = route.route("ZachTwo")!
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
            let routePlanRoot = MockQTRoutePlan()
            when("debugDescription called") {
                print(routePlanRoot)
                let desc = routePlanRoot.debugDescription
                then("the output should match the expected length") {
                    XCTAssertEqual(desc.lengthOfBytes(using: .utf8), 239)
                }
            }
        }
    }

    func testHashable() {
        given("routePlan") {
            let routePlanRoot = MockQTRoutePlan()
            when("the root routes are added to a set") {
                let result = Set<QTRoute>(routePlanRoot.routes)
                then("it should be able to retrieve all four routes") {
                    XCTAssertEqual(result.count, 4)
                    XCTAssertNotNil(result.first{ $0.id == "Alpha" })
                    XCTAssertNotNil(result.first{ $0.id == "Bravo" })
                    XCTAssertNotNil(result.first{ $0.id == "Charlie" })
                    XCTAssertNotNil(result.first{ $0.id == "Zach" })
                }
            }
        }
    }

    func testFlattened() {
        given("routePlan") {
            let routePlanRoot = MockQTRoutePlan()
            when("the root routes are flattened") {
                let flats = routePlanRoot.flattened
                then("it should contain all the routes") {
                    XCTAssertEqual(flats.count, 11)
                }
            }
        }
    }

    func testShallowClone() {
        given("route from routePlan") {
            let routePlanRoot = MockQTRoutePlan()
            let route = routePlanRoot.route("Bravo")!.route("BravoOne")!
            when("shallow cloning") {
                let result = QTRoute(shallowClone: route)
                then("it should not be the same object") {
                    XCTAssert(result !== route)
                }
                then("it should copy the id and runtime dependencies") {
                    XCTAssertEqual(result.id, "BravoOne")
                    XCTAssertNotNil(result.dependencies.first { $0 == "bravoScoreIndex" })
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
            let routePlanRoot = MockQTRoutePlan()
            let route = routePlanRoot.route("Bravo")!
            when("deep cloning") {
                let result = QTRoute(deepClone: route)
                then("it should not be the same object") {
                    XCTAssert(result !== route)
                }
                then("it should copy the id and runtime dependencies") {
                    XCTAssertEqual(result.id, "Bravo")
                }
                with("parent set to nil") {
                    XCTAssertNil(result.parent)
                }
                with("child routes deeply cloned") {
                    let child1 = route.route("BravoOne")
                    let child2 = child1?.route("BravoOneAlpha")
                    let childClone1 = result.route("BravoOne")
                    let childClone2 = childClone1?.route("BravoOneAlpha")
                    XCTAssertNotNil(childClone1)
                    XCTAssertNotNil(childClone1)
                    XCTAssert(childClone1 !== child1)
                    XCTAssert(childClone2 !== child2)
                    with("runtime dependencies set") {
                        XCTAssertNotNil(childClone1?.dependencies.first { $0 == "bravoScoreIndex" })
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

