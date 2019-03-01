
import UIKit

class MockNavigationController: UINavigationController {

    var navigationStack: [UIViewController] = []

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationStack = [rootViewController]
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var topViewController: UIViewController? {
        get { return navigationStack.first }
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.pushViewController(viewController, animated: animated, completion: { })
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        navigationStack.insert(viewController, at: 0)
        viewController.view.frame = self.view.bounds
        completion()
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        return self.popViewController(animated: animated, completion: { })
    }

    override func popViewController(animated: Bool, completion: @escaping () -> Void) -> UIViewController? {
        let vc = navigationStack.remove(at: 0)
        completion()
        return vc
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return self.popToRootViewController(animated: animated, completion: { })
    }

    override func popToRootViewController(animated: Bool, completion: @escaping () -> Void) -> [UIViewController]? {
        let vcs = Array<UIViewController>(navigationStack.dropFirst())
        navigationStack = [navigationStack.first!]
        completion()
        return vcs
    }
}
