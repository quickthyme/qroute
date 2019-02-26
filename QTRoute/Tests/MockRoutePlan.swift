
func MockRoutePlan() -> QTRoute {
    return
        QTRoute("Root",
              QTRoute("Log",
                    QTRoute("Log Entry Detail", runtimeDependencies: ["id":Int.self, "name":String.self])),
              QTRoute("To-Do",
                    QTRoute("To-Do Detail", runtimeDependencies: ["id":Int.self],
                            QTRoute("To-Do Edit Image"))),
              QTRoute("Settings",
                    QTRoute("Profile Settings"),
                    QTRoute("Payment Settings")),
              QTRoute("Help",
                    QTRoute("Contact Us"),
                    QTRoute("Message Center")))
}
