// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

struct BaseLayout {
    let title: String
    let content: () -> String
    func render() -> String {
        """
        <!DOCTYPE html>
        <html>
        <head>
          <meta charset="UTF-8">
          <title>\(title)</title>
          <script src="https://unpkg.com/htmx.org@1.9.10"></script>
        </head>
        <body>\(content())</body>
        </html>
        """
    }
}
