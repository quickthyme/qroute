
import UIKit

class ToDoViewController: UIViewController, QTRoutable {
    var routeInput: QTRoutableInput?
    var routeResolver: QTRouteResolving?
    var routeDriver: QTRouteDriving?
}

extension ToDoViewController: ToDoTableViewManagerDelegate {
    func toDoTableViewManager(_ manager: ToDoTableViewManager, didSelectId id: Int) {
        routeDriver?.driveTo(AppRoute.id.ToDoDetail, from: self,
                             input: ["toDoId": id], completion: nil)
    }
}
