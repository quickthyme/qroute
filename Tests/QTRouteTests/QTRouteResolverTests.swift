
import XCTest
import QTRoute

class QTRouteResolverTests: XCTestCase {

    var subject: QTRouteResolver!
    var stubResolvers: StubQTResolverActions!
    var mockRoutable: MockQTRoutable!
    let route = QTRoute("route", dependencies: ["needInput"])

    override func setUp() {
        stubResolvers = StubQTResolverActions()
        subject = QTRouteResolver(route,
                                  toChild: stubResolvers.ToChild(),
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
                XCTAssertTrue(stubResolvers.didCall_ToChild)
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

    func test_mergeInputDependencies_filter() {
        given("route with only one dependency ('needInput')") {
            XCTAssertEqual(route.dependencies, ["needInput"])
            XCTAssertNil(mockRoutable.routeInput)

            when("calling mergeInputDependencies with more than one input") {
                subject.mergeInputDependencies(target: mockRoutable,
                                               input: ["needInput":"stephanie",
                                                       "noDisassemble":true])

                then("it should only merge the dependent value") {
                    XCTAssertNotNil(mockRoutable.routeInput)
                    XCTAssertEqual(mockRoutable.routeInput!.count, 1)
                    XCTAssertNotNil(mockRoutable.routeInput!["needInput"])
                    XCTAssertNil(mockRoutable.routeInput!["noDisassemble"])
                }
            }
        }
    }

    func test_mergeInputDependencies_retain() {
        given("route with dependencies and some input data already set") {
            let needyRoute = QTRoute("needy", dependencies:["key1","key2","activator"])
            subject.route = needyRoute
            mockRoutable.routeInput = ["key1":"ABC","key2":"123"]

            when("calling mergeInputDependencies with more than one input") {
                subject.mergeInputDependencies(target: mockRoutable,
                                               input: ["activator":-1,
                                                       "key8":"ZYX"])

                then("it should keep existing values and merge the relevant new one") {
                    XCTAssertNotNil(mockRoutable.routeInput)
                    XCTAssertEqual(mockRoutable.routeInput!.count, 3)
                    XCTAssertEqual(mockRoutable.routeInput?["key1"] as? String, "ABC")
                    XCTAssertEqual(mockRoutable.routeInput?["key2"] as? String, "123")
                    XCTAssertEqual(mockRoutable.routeInput?["activator"] as? Int, -1)
                    XCTAssertNil(mockRoutable.routeInput!["key8"])
                }
            }
        }
    }

    func test_mergeInputDependencies_self() {
        given("route with dependency") {
            XCTAssertEqual(route.dependencies, ["needInput"])
            XCTAssertNil(mockRoutable.routeInput)

            when("calling resolveRouteToSelf against default ToSelf handler") {
                let defaultImpl = QTRouteResolver(route,
                                                  toChild: QTRouteResolver.DefaultAction.ToChildNoOp(),
                                                  toParent: QTRouteResolver.DefaultAction.ToParentNoOp(),
                                                  toSelf: QTRouteResolver.DefaultAction.ToSelf())
                mockRoutable.routeResolver = defaultImpl

                defaultImpl.resolveRouteToSelf(from: mockRoutable,
                                               input: ["needInput":"confirm"],
                                               animated: false,
                                               completion: {_ in})

                then("it should have merged the input") {
                    XCTAssertNotNil(mockRoutable.routeInput)
                    XCTAssertEqual(mockRoutable.routeInput?["needInput"] as? String, "confirm")
                }
            }
        }
    }
}
