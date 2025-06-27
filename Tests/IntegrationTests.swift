// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

import XCTest

import Hummingbird
import HummingbirdTesting
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
}

enum ResponseGeneratorEncoder {
    static func execute(_ html: String, from request: Request, context: some RequestContext) throws -> Response {
        var buffer = ByteBufferAllocator().buffer(capacity: html.utf8.count)
        buffer.writeString(html)
        
        var headers = HTTPFields()
        headers.reserveCapacity(2)
        headers.append(.init(name: .contentType, value: "text/html; charset=utf-8"))
        headers.append(.init(name: .contentLength, value: buffer.readableBytes.description))
        
        return Response(
            status: .ok,
            headers: headers,
            body: .init(byteBuffer: buffer)
        )
    }
}

enum AppComposer {
    static func execute(with configuration: ApplicationConfiguration, store: CounterStore) -> some ApplicationProtocol {
        let router = Router()
        let counterController = CounterController(store: store) |> CounterControllerAdapter.init
        router.get("/counter", use: counterController.get)
        router.post("/increase", use: counterController.postIncrease)
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

class IntegrationTests: XCTestCase {
    
    class InMemoryCounterStore: CounterStore {
        private var counter = 0
        func load() async throws -> Int {
            counter
        }
        
        func increase() async throws -> Int {
            counter += 1
            return counter
        }
        
        func decrease() async throws -> Int {
            counter -= 1
            return counter
        }
    }
    
    func test() async throws {
        let app = AppComposer.execute(with: .init(), store: InMemoryCounterStore())
        _ = try await app.test(.router) { client in
            let response0 = try await client.executeRequest(
                uri: "/counter",
                method: .get,
                headers: [:],
                body: nil
            )
            
            var buffer = response0.body
            let renderedCount0 = buffer.readString(length: buffer.readableBytes)
            XCTAssertEqual(renderedCount0, "<span>0</span>")
            
            let response1 = try await client.executeRequest(
                uri: "/increase",
                method: .post,
                headers: [:],
                body: nil
            )
            
            buffer = response1.body
            let renderedCount1 = buffer.readString(length: buffer.readableBytes)
            XCTAssertEqual(renderedCount1, "<span>1</span>")
            
        }
    }
}
