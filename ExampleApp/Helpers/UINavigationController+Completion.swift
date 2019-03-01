
import UIKit

extension UINavigationController {

    @objc public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    @discardableResult
    @objc func popViewController(animated: Bool, completion: @escaping () -> Void) -> UIViewController? {
        let vc = popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return vc
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
        return vc
    }

    @discardableResult
    @objc func popToRootViewController(animated: Bool, completion: @escaping () -> Void) -> [UIViewController]? {
        let vcs = popToRootViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return vcs
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
        return vcs
    }
}
