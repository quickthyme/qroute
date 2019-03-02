
import UIKit
import QTRoute

class MockViewControllerRoutable: MockViewController, QTRoutable {

    var routeInput: QTRoutableInput?
    var routeResolver: QTRouteResolving?

    init(_ route: QTRoute? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.routeResolver = MockQTRouteResolver(route ?? QTRoute("\(type(of: self))"))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var embeddedInWindow: MockViewControllerRoutable {
        return super.embeddedInWindow as! MockViewControllerRoutable
    }

    override var inMockNavigationController: MockViewControllerRoutable {
        return super.inMockNavigationController as! MockViewControllerRoutable
    }
}
