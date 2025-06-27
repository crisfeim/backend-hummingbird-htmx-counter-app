// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.


import Hummingbird

public enum AppComposer {
    public static func execute(with configuration: ApplicationConfiguration, store: CounterStore) -> some ApplicationProtocol {
        let router = Router()
        let counterController = CounterController(store: store) |> CounterControllerAdapter.init
        let indexController = IndexController() |> IndexControllerAdapter.init
        
        router.get("/counter", use: counterController.get)
        router.post("/increase", use: counterController.postIncrease)
        router.post("/decrease", use: counterController.postDecrease)
        router.get("/", use: indexController.get)
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

