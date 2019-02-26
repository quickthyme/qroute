
func AppRoutePlan() -> QTRoute {
    return
        QTRoute("Root",
                QTRoute("To-Do",
                        QTRoute("To-Do Detail", runtimeDependencies: ["id":Int.self],
                                QTRoute("To-Do Edit Image"))),
                QTRoute("Help",
                        QTRoute("Contact Us"),
                        QTRoute("Message Center")))
}
