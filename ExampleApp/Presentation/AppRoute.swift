
class AppRoute {

    struct id {
        static let Root = "Root"
        static let ToDo = "ToDo"
        static let ToDoDetail = "ToDoDetail"
        static let Help = "Help"
        static let ContactUs = "ContactUs"
        static let MessageCenter = "MessageCenter"
    }

    static var plan: QTRoute =
        QTRoute(id.Root,
                QTRoute(id.ToDo,
                        QTRoute(id.ToDoDetail,
                                dependencies: ["toDoId"])),
                QTRoute(id.Help,
                        QTRoute(id.ContactUs),
                        QTRoute(id.MessageCenter)))

    static var driver: QTRouteDriving? = QTRouteDriver()

    static weak var rootRoutable: RootViewController? = nil
}
