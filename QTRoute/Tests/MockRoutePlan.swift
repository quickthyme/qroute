
func MockRoutePlan() -> QTRoute {
    return
        QTRoute("Root",
              QTRoute("Log",
                    QTRoute("Log Entry Detail", dependencies: ["logId", "logName"])),
              QTRoute("To-Do",
                    QTRoute("To-Do Detail", dependencies: ["todoId"],
                            QTRoute("To-Do Edit Image"))),
              QTRoute("Settings",
                    QTRoute("Profile Settings"),
                    QTRoute("Payment Settings")),
              QTRoute("Help",
                    QTRoute("Contact Us"),
                    QTRoute("Message Center")))
}
