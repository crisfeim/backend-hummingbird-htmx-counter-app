// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

struct IndexController {
    func get() -> String {
        let app =  CounterLoadingView().render() +>
        ButtonView(label: "Increase", postPath: "/increase", elementTarget: "#counter").render() +>
        ButtonView(label: "Decrease", postPath: "/decrease", elementTarget: "#counter").render()
        
        return BaseLayout(title: "Counter") { app }.render()
    }
}


infix operator +>: AdditionPrecedence
func +> (lhs: String, rhs: String) -> String {
    lhs + "\n" + rhs
}
