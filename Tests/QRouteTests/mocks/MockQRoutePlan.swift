
import QRoute

public func MockQRoutePlan() -> QRoute {
    return
        QRoute("Root",
              QRoute("Alpha"),
              QRoute("Bravo",
                    QRoute("BravoOne", dependencies: ["bravoScoreIndex"],
                            QRoute("BravoOneAlpha"))),
              QRoute("Charlie",
                    QRoute("CharlieOne"),
                    QRoute("CharlieTwo")),
              QRoute("Zach",
                    QRoute("ZachOne"),
                    QRoute("ZachTwo")))
}
