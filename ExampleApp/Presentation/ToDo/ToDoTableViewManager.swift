
import UIKit

@objc protocol ToDoTableViewManagerDelegate: class {
    func toDoTableViewManager(_ manager: ToDoTableViewManager, didSelectId id: Int)
}

class ToDoTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var delegate: ToDoTableViewManagerDelegate!

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 26
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath)
        cell.textLabel?.text = "Item \(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.toDoTableViewManager(self, didSelectId: indexPath.row)
    }
}
