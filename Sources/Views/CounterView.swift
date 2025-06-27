// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

struct CounterView {
    let count: Int
    func render() -> String {
        """
        <span>\(count)</span>
        """
    }
}
