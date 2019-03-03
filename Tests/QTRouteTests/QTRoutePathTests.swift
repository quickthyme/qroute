
import XCTest
import QTRoute

class QTRoutePathTests: XCTestCase {

    func testFindPath_single() {
        given("simple route with no parent or children") {
            let route = QTRoute("island")

            when("finding path to another route") {
                let path = route.findPath(to: "another-island")
                then("it should return empty route") {
                    XCTAssertEqual(path, [])
                }
            }

            when("trying to find path to itself") {
                let path = route.findPath(to: "island")
                then("it should return path to self") {
                    XCTAssertEqual(path, [.SELF(route)])
                }
            }
        }
    }

    func testFindPath_two() {
        given("2 routes: route with child route") {
            let child = QTRoute("island")
            let parent = QTRoute("archipelago", child)

            when("either tries to find path to empty target") {
                let path1 = parent.findPath(to: "")
                let path2 = child.findPath(to: "")
                then("it should return emmpty path") {
                    XCTAssertEqual(path1, [])
                    XCTAssertEqual(path2, [])
                }
            }

            when("either tries to find path to undefined route") {
                let path1 = parent.findPath(to: "continent")
                let path2 = child.findPath(to: "continent")
                then("it should return emmpty path") {
                    XCTAssertEqual(path1, [])
                    XCTAssertEqual(path2, [])
                }
            }

            when("either tries to find path to itself") {
                let parentPath = parent.findPath(to: "archipelago")
                let childPath = child.findPath(to: "island")
                then("it should return path to self") {
                    XCTAssertNotNil(parentPath)
                    XCTAssertEqual(parentPath, [.SELF(parent)])
                    XCTAssertNotNil(childPath)
                    XCTAssertEqual(childPath, [.SELF(child)])
                }
            }

            when("parent tries to find path to child") {
                let path = parent.findPath(to: "island")
                then("it should return path with single step to child [(DOWN, child)]") {
                    XCTAssertEqual(path, [.DOWN(child)])
                }
            }

            when("child tries to find path to parent") {
                let path = child.findPath(to: "archipelago")
                then("it should return path with single step to parent [(UP, parent)]") {
                    XCTAssertEqual(path, [.UP(parent)])
                }
            }
        }
    }

    func testFindPath_many() {
        given("route plan with many nested routes (MockQTRoutePlan)") {
            let root = MockQTRoutePlan()
            let charlie = root.routes.first { $0.id == "Charlie" }!
            let charlieOne = charlie.routes.first { $0.id == "CharlieOne" }!
            let help = root.routes.first { $0.id == "Zach" }!
            let zachOne = help.routes.first { $0.id == "ZachOne" }!
            let zachTwo = help.routes.first { $0.id == "ZachTwo" }!

            when("'ZachTwo' tries to find empty target") {
                let path = zachTwo.findPath(to: "")
                then("it should return empty path") {
                    XCTAssertEqual(path, [])
                }
            }

            when("'ZachTwo' tries to find invalid Route") {
                let path = zachTwo.findPath(to: "Invalid")
                then("it should return empty path") {
                    XCTAssertEqual(path, [])
                }
            }

            when("'ZachTwo' tries to find 'Zach'") {
                let path = zachTwo.findPath(to: "Zach")
                then("it should return path with single step UP to Zach [(UP, Zach)]") {
                    XCTAssertEqual(path.count, 1)
                    XCTAssertEqual(path, [.UP(help)])
                }
            }

            when("'ZachTwo' tries to find 'Root'") {
                let path = zachTwo.findPath(to: "Root")
                then("it should return path with two steps UP to Root [(UP, Zach), (UP, Root)]") {
                    XCTAssertEqual(path.count, 2)
                    XCTAssertEqual(path,
                                   [.UP(help),
                                    .UP(root)]
                    )
                }
            }

            when("'Root' tries to find 'ZachTwo'") {
                let path = root.findPath(to: "ZachTwo")
                then("it should return path with two steps DOWN to ZachTwo [(DOWN, Zach), (DOWN, ZachTwo)]") {
                    XCTAssertEqual(path.count, 2)
                    XCTAssertEqual(path,
                                   [.DOWN(help),
                                    .DOWN(zachTwo)]
                    )
                }
            }

            when("'ZachTwo' tries to find 'ZachOne'") {
                let path = zachTwo.findPath(to: "ZachOne")
                then("it should return path with two steps: [(UP, Zach), (DOWN, ZachOne)]") {
                    XCTAssertEqual(path.count, 2)
                    XCTAssertEqual(path,
                                   [.UP(help),
                                    .DOWN(zachOne)]
                    )
                }
            }

            when("'ZachTwo' tries to find 'CharlieOne'") {
                let path = zachTwo.findPath(to: "CharlieOne")
                then("it should return path with four steps: [UP, UP, DOWN, DOWN]") {
                    XCTAssertEqual(path.count, 4)
                    XCTAssertEqual(path,
                                   [.UP(help),
                                    .UP(root),
                                    .DOWN(charlie),
                                    .DOWN(charlieOne)]
                    )
                }
            }

            when("'ZachTwo' tries to find lowest common ancestor for 'ZachOne'") {
                let commonAncestor = zachTwo.findLowestCommonAncestor(otherRoute: zachOne)
                then("it should return 'Zach'") {
                    XCTAssertEqual(commonAncestor, help)
                }
            }

            when("'ZachTwo' tries to find lowest common ancestor for invalid route") {
                let foreignRoute = QTRoute("La La Land")
                let commonAncestor = zachTwo.findLowestCommonAncestor(otherRoute: foreignRoute)
                then("it should return root") {
                    XCTAssertEqual(commonAncestor, root)
                }
            }
        }
    }

    func testHashable() {
        given("path from parent to child") {
            let child = QTRoute("child")
            let parent = QTRoute("parent", child)
            let path = parent.findPath(to: child.id)
            when("converted to a set") {
                let result = Set<QTRoutePathNode>( path )
                then("it should be able to retrieve the path node") {
                    XCTAssertEqual(result.count, 1)
                    XCTAssertNotNil(result.first{ $0.route.id == "child" })
                }
            }
        }
    }
}
