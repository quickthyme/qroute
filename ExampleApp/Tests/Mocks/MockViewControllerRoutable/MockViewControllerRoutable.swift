
import UIKit
import XCTest

class MockViewControllerRoutable: UIViewController, QTRoutable {
    private static let storyboardName = "MockViewControllerRoutable"

    var routeInput: QTRoutableInput?
    var routeResolver: QTRouteResolving?

    override var navigationController: UINavigationController? {
        get { return mockNavigationController }
    }

    var mockNavigationController: MockNavigationController?
    var inMockNavigationController: MockViewControllerRoutable {
        mockNavigationController = MockNavigationController(rootViewController: self)
        return self
    }

    var parentWindow: UIWindow?
    var inWindow: MockViewControllerRoutable {
        parentWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        parentWindow!.rootViewController = self.navigationController ?? self
        return self
    }

    init(_ route: QTRoute? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.routeResolver = MockRouteResolver(route ?? QTRoute(type(of: self).storyboardName))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    static func fromStoryboard(_ route: QTRoute? = nil) -> MockViewControllerRoutable {
        let vc = StoryboardLoader.loadViewController(from: storyboardName) as! MockViewControllerRoutable
        vc.routeResolver = MockRouteResolver(route ?? QTRoute(storyboardName))
        return vc
    }

    var _presentedViewController: UIViewController?
    override var presentedViewController: UIViewController? {
        get { return _presentedViewController }
        set { _presentedViewController = newValue }
    }

    var wasCalled_present: Bool = false
    var valueFore_present_completion: (()->())?
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        wasCalled_present = true
        valueFore_present_completion = completion
        _presentedViewController = viewControllerToPresent
    }
}
