// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

import Hummingbird

struct IndexControllerAdapter {
    let controller: IndexController
    @Sendable func get(request: Request, context: BasicRequestContext) async throws -> Response {
        let index = controller.get()
        return try ResponseGeneratorEncoder.execute(index, from: request, context: context)
    }
}
