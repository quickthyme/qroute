
import QTRoute

public func MockQTRoutePlan() -> QTRoute {
    return
        QTRoute("Root",
              QTRoute("Alpha"),
              QTRoute("Bravo",
                    QTRoute("BravoOne", dependencies: ["bravoScoreIndex"],
                            QTRoute("BravoOneAlpha"))),
              QTRoute("Charlie",
                    QTRoute("CharlieOne"),
                    QTRoute("CharlieTwo")),
              QTRoute("Zach",
                    QTRoute("ZachOne"),
                    QTRoute("ZachTwo")))
}
