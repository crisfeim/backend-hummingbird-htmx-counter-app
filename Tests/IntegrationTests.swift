// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

import XCTest

import Hummingbird
import HummingbirdTesting
import HummingBirdCounterApp

class IntegrationTests: XCTestCase {
    
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
            
            
            let response2 = try await client.executeRequest(
                uri: "/decrease",
                method: .post,
                headers: [:],
                body: nil
            )
            
            buffer = response2.body
            let renderedCount2 = buffer.readString(length: buffer.readableBytes)
            XCTAssertEqual(renderedCount2, "<span>0</span>")
        }
    }
}

