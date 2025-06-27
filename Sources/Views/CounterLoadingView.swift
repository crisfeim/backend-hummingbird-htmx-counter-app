// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

struct CounterLoadingView {
    func render() -> String {
        """
        <div
        id="counter"
        hx-get="/counter"
        hx-trigger="load"
        hx-swap="innerHTML">
            loading....
        </div>
        """
    }
}
