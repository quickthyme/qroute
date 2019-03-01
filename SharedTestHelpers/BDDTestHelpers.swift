
import XCTest

class Captured<T> { var value: T? }

extension XCTestCase {
    @discardableResult
    func given<Result>(_ label: String, block: () throws -> Result) rethrows -> Result {
        return try XCTContext.runActivity(named: "GIVEN \(label)") { _ in try block() }
    }

    @discardableResult
    func when<Result>(_ label: String, block: () throws -> Result) rethrows -> Result {
        return try XCTContext.runActivity(named: "WHEN \(label)") { _ in try block() }
    }

    @discardableResult
    func then<Result>(_ label: String, block: () throws -> Result) rethrows -> Result {
        return try XCTContext.runActivity(named: "THEN \(label)") { _ in try block() }
    }

    @discardableResult
    func with<Result>(_ label: String, block: () throws -> Result) rethrows -> Result {
        return try XCTContext.runActivity(named: "WITH \(label)") { _ in try block() }
    }
}
