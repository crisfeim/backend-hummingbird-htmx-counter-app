// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.


import Hummingbird
import HummingBirdCounterApp

enum AppComposer {
    static func execute(with configuration: ApplicationConfiguration, store: CounterStore) -> some ApplicationProtocol {
        let router = Router()
        let counterController = CounterController(store: store) |> CounterControllerAdapter.init
        router.get("/counter", use: counterController.get)
        router.post("/increase", use: counterController.postIncrease)
        router.post("/decrease", use: counterController.postDecrease)
        return Application(router: router, configuration: configuration)
    }
}

precedencegroup PipePrecedence {
    associativity: left
    lowerThan: LogicalDisjunctionPrecedence
}

infix operator |> : PipePrecedence
func |><A, B>(lhs: A, rhs: (A) -> B) -> B {
    rhs(lhs)
}

