// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

struct ButtonView {
    let label: String
    let postPath: String
    let elementTarget: String
    func render() -> String {
        """
        <button
        hx-post="\(postPath)"
        hx-target="\(elementTarget)"
        hx-swap="innerHTML">
            \(label)
        </button>
        """
    }
}
