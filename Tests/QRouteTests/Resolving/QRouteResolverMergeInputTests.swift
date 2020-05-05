import XCTest
import QRoute

class QRouteResolverMergeInputTests: XCTestCase {

    var subject: QRouteResolver!
    var stubResolvers: StubQResolverActions!
    var mockRoutable: QRoutableMock!
    let route = QRoute("route", dependencies: ["needInput"])
    var onInputValue: QRouteResolving.Input!

    override func setUp() {
        stubResolvers = StubQResolverActions()
        onInputValue = [:]
        subject = QRouteResolver(route,
                                 toChild: stubResolvers.ToChild1(),
                                 toParent: stubResolvers.ToParent(),
                                 toSelf: stubResolvers.ToSelf(),
                                 onInput: { self.onInputValue = $0 })
        mockRoutable = QRoutableMock(subject)
    }

    func test_mergeInputDependencies_filter() {
        given("route with only one dependency ('needInput')") {
            XCTAssertEqual(route.dependencies, ["needInput"])
            XCTAssertNil(mockRoutable.routeResolver.input["needInput"])

            when("calling mergeInputDependencies with more than one input") {
                subject.mergeInputDependencies(input: ["needInput":"stephanie",
                                                       "noDisassemble":true])

                then("it should only merge the dependent value") {
                    XCTAssertEqual(mockRoutable.routeResolver.input.count, 1)
                    XCTAssertNotNil(mockRoutable.routeResolver.input["needInput"])
                    XCTAssertNil(mockRoutable.routeResolver.input["noDisassemble"])
                }
                then("it should raise `onInput` with its input") {
                    XCTAssertEqual(onInputValue.count, mockRoutable.routeResolver.input.count)
                }
            }
        }
    }

    func test_mergeInputDependencies_retain() {
        given("route with dependencies and some input data already set") {
            let needyRoute = QRoute("needy", dependencies:["key1","key2","activator"])
            subject.route = needyRoute
            mockRoutable.routeResolver.input = ["key1":"ABC","key2":"123"]

            when("calling mergeInputDependencies with more than one input") {
                subject.mergeInputDependencies(input: ["activator":-1,
                                                       "key8":"ZYX"])

                then("it should keep existing values and merge the relevant new one") {
                    XCTAssertEqual(mockRoutable.routeResolver.input.count, 3)
                    XCTAssertEqual(mockRoutable.routeResolver.input["key1"] as? String, "ABC")
                    XCTAssertEqual(mockRoutable.routeResolver.input["key2"] as? String, "123")
                    XCTAssertEqual(mockRoutable.routeResolver.input["activator"] as? Int, -1)
                    XCTAssertNil(mockRoutable.routeResolver.input["key8"])
                }
                then("it should raise `onInput` with its input") {
                    XCTAssertEqual(onInputValue.count, mockRoutable.routeResolver.input.count)
                }
            }
        }
    }

    func test_mergeInputDependencies_collision() {
        given("route with dependencies and some input data already set") {
            let loadedRoute = QRoute("loaded", dependencies:["name","address","score"])
            subject.route = loadedRoute
            mockRoutable.routeResolver.input = ["name":"Paul",
                                                        "address":"123",
                                                        "score":3]

            when("calling mergeInputDependencies with input that has already been set") {

                subject.mergeInputDependencies(input: ["score":8])

                then("it should update the existing value and not affect the rest") {
                    XCTAssertEqual(mockRoutable.routeResolver.input.count, 3)
                    XCTAssertEqual(mockRoutable.routeResolver.input["name"] as? String, "Paul")
                    XCTAssertEqual(mockRoutable.routeResolver.input["address"] as? String, "123")
                    XCTAssertEqual(mockRoutable.routeResolver.input["score"] as? Int, 8)
                }
                then("it should raise `onInput` with its input") {
                    XCTAssertEqual(onInputValue.count, mockRoutable.routeResolver.input.count)
                }
            }
        }
    }

    func test_mergeInputDependencies_self() {
        given("default ToSelf handler, route with dependency") {
            subject = QRouteResolver(route,
                                      toChild: QRouteResolver.DefaultAction.ToChildNoOp(),
                                      toParent: QRouteResolver.DefaultAction.ToParentNoOp(),
                                      toSelf: QRouteResolver.DefaultAction.ToSelf(),
                                      onInput: { self.onInputValue = $0 })
            mockRoutable.routeResolver = subject
            XCTAssertEqual(route.dependencies, ["needInput"])
            XCTAssertNil(mockRoutable.routeResolver.input["needInput"])

            when("calling resolveRouteToSelf") {
                subject.resolveRouteToSelf(from: mockRoutable,
                                           input: ["needInput":"confirm"],
                                           animated: false,
                                           completion: {_ in})

                then("it should have merged the input") {
                    XCTAssertEqual(mockRoutable.routeResolver.input["needInput"] as? String, "confirm")
                }
                then("it should raise `onInput` with its input") {
                    XCTAssertEqual(onInputValue.count, mockRoutable.routeResolver.input.count)
                }
            }
        }
    }
}
