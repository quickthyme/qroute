
import XCTest

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
                    XCTAssertEqual(path, [QTRoutePathNode(.SELF, route)])
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
                    XCTAssertEqual(parentPath, [QTRoutePathNode(.SELF, parent)])
                    XCTAssertNotNil(childPath)
                    XCTAssertEqual(childPath, [QTRoutePathNode(.SELF, child)])
                }
            }

            when("parent tries to find path to child") {
                let path = parent.findPath(to: "island")
                then("it should return path with single step to child [(DOWN, child)]") {
                    XCTAssertEqual(path, [QTRoutePathNode(.DOWN, child)])
                }
            }

            when("child tries to find path to parent") {
                let path = child.findPath(to: "archipelago")
                then("it should return path with single step to parent [(UP, parent)]") {
                    XCTAssertEqual(path, [QTRoutePathNode(.UP, parent)])
                }
            }
        }
    }

    func testFindPath_many() {
        given("route plan with many nested routes (MockRoutePlan)") {
            let root = MockRoutePlan()
            let settings = root.routes.first { $0.id == "Settings" }!
            let profileSettings = settings.routes.first { $0.id == "Profile Settings" }!
            let help = root.routes.first { $0.id == "Help" }!
            let contactUs = help.routes.first { $0.id == "Contact Us" }!
            let messageCenter = help.routes.first { $0.id == "Message Center" }!

            when("'Message Center' tries to find empty target") {
                let path = messageCenter.findPath(to: "")
                then("it should return empty path") {
                    XCTAssertEqual(path, [])
                }
            }

            when("'Message Center' tries to find invalid Route") {
                let path = messageCenter.findPath(to: "Invalid")
                then("it should return empty path") {
                    XCTAssertEqual(path, [])
                }
            }

            when("'Message Center' tries to find 'Help'") {
                let path = messageCenter.findPath(to: "Help")
                then("it should return path with single step UP to Help [(UP, Help)]") {
                    XCTAssertEqual(path.count, 1)
                    XCTAssertEqual(path, [QTRoutePathNode(.UP, help)])
                }
            }

            when("'Message Center' tries to find 'Root'") {
                let path = messageCenter.findPath(to: "Root")
                then("it should return path with two steps UP to Root [(UP, Help), (UP, Root)]") {
                    XCTAssertEqual(path.count, 2)
                    XCTAssertEqual(path,
                                   [QTRoutePathNode(.UP, help),
                                    QTRoutePathNode(.UP, root)]
                    )
                }
            }

            when("'Root' tries to find 'Message Center'") {
                let path = root.findPath(to: "Message Center")
                then("it should return path with two steps DOWN to Message Center [(DOWN, Help), (DOWN, Message Center)]") {
                    XCTAssertEqual(path.count, 2)
                    XCTAssertEqual(path,
                                   [QTRoutePathNode(.DOWN, help),
                                    QTRoutePathNode(.DOWN, messageCenter)]
                    )
                }
            }

            when("'Message Center' tries to find 'Contact Us'") {
                let path = messageCenter.findPath(to: "Contact Us")
                then("it should return path with two steps: [(UP, Help), (DOWN, Contact Us)]") {
                    XCTAssertEqual(path.count, 2)
                    XCTAssertEqual(path,
                                   [QTRoutePathNode(.UP, help),
                                    QTRoutePathNode(.DOWN, contactUs)]
                    )
                }
            }

            when("'Message Center' tries to find 'Profile Settings'") {
                let path = messageCenter.findPath(to: "Profile Settings")
                print("\n\n\(path)\n\n")
                then("it should return path with four steps: [UP, UP, DOWN, DOWN]") {
                    XCTAssertEqual(path.count, 4)
                    XCTAssertEqual(path,
                                   [QTRoutePathNode(.UP, help),
                                    QTRoutePathNode(.UP, root),
                                    QTRoutePathNode(.DOWN, settings),
                                    QTRoutePathNode(.DOWN, profileSettings)]
                    )
                }
            }

            when("'Message Center' tries to find lowest common ancestor for 'Contact Us'") {
                let commonAncestor = messageCenter.findLowestCommonAncestor(otherRoute: contactUs)
                then("it should return 'Help'") {
                    XCTAssertEqual(commonAncestor, help)
                }
            }

            when("'Message Center' tries to find lowest common ancestor for invalid route") {
                let foreignRoute = QTRoute("La La Land")
                let commonAncestor = messageCenter.findLowestCommonAncestor(otherRoute: foreignRoute)
                then("it should return root") {
                    XCTAssertEqual(commonAncestor, root)
                }
            }
        }
    }

    func testDebugDescription() {

        given("path from parent to child") {
            let child = QTRoute("child")
            let parent = QTRoute("parent", child)
            let path = parent.findPath(to: child.id)

            when("debugDescription called") {
                let desc = "\(path)"
//                print(desc)
                then("the output should match the expected length") {
                    XCTAssertEqual(desc.lengthOfBytes(using: .utf8), 35)
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
