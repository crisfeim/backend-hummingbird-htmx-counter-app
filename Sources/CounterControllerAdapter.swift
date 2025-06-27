// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

import Hummingbird

public struct CounterControllerAdapter: @unchecked Sendable {
    private let controller: CounterController
    public init(controller: CounterController) {
        self.controller = controller
    }
    
    @Sendable public func get(request: Request, context: BasicRequestContext) async throws -> Response {
        let body = try await controller.get()
        return try ResponseGeneratorEncoder.execute(body, from: request, context: context)
    }
    
    @Sendable public func postIncrease(request: Request, context: BasicRequestContext) async throws -> Response {
        let body = try await controller.postIncrease()
        return try ResponseGeneratorEncoder.execute(body, from: request, context: context)
    }
    
    @Sendable public func postDecrease(request: Request, context: BasicRequestContext) async throws -> Response {
        let body = try await controller.postDecrease()
        return try ResponseGeneratorEncoder.execute(body, from: request, context: context)
    }
}
