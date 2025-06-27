// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

import Hummingbird
import HummingBirdCounterApp

struct CounterControllerAdapter: @unchecked Sendable {
    let controller: CounterController
    @Sendable func get(request: Request, context: BasicRequestContext) async throws -> Response {
        let body = try await controller.get()
        return try ResponseGeneratorEncoder.execute(body, from: request, context: context)
    }
    
    @Sendable func postIncrease(request: Request, context: BasicRequestContext) async throws -> Response {
        let body = try await controller.postIncrease()
        return try ResponseGeneratorEncoder.execute(body, from: request, context: context)
    }
    
    @Sendable func postDecrease(request: Request, context: BasicRequestContext) async throws -> Response {
        let body = try await controller.postDecrease()
        return try ResponseGeneratorEncoder.execute(body, from: request, context: context)
    }
}
