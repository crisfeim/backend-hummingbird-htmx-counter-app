// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.
import XCTest

class CounterControllerTests: XCTestCase {
    
    protocol CounterStore {
        func load() async throws -> Int
        func increase() async throws -> Int
    }
    
    class CounterStoreSpy: CounterStore {
        var capturedMessages = [Message]()
        
        enum Message {
            case load
        }
        
        func load() async throws -> Int {
            capturedMessages.append(.load)
            return 0
        }
        
        func increase() async throws -> Int {
            fatalError("dont needed yet")
        }
    }
    struct CounterController {
        let store: CounterStore
        
        func get() async throws -> Int {
            try await store.load()
        }
        
        func postIncrease() async throws -> Int {
            try await store.increase()
        }
    }
    
    
    func test_init_doesntMessageStore() {
        let storeSpy = CounterStoreSpy()
        let _ = CounterController(store: storeSpy)
        XCTAssertTrue(storeSpy.capturedMessages.isEmpty)
    }
    
    func test_get_deliversErrorOnStoreError() async throws {
        struct CounterStoreStub: CounterStore {
            let error: NSError
            func load() async throws -> Int {
                throw error
            }
            
            func increase() async throws -> Int {
                fatalError("shouldn't be invoked in this test")
            }
        }
        let storeStub = CounterStoreStub(error: anyError())
        let sut = CounterController(store: storeStub)
        
        await XCTAssertThrowsErrorAsync(try await sut.get()) { error in
            XCTAssertEqual(error as NSError, anyError())
        }
    }
    
    func test_postIncrease_deliversErrorOnStoreError() async throws {
        struct CounterStoreStub: CounterStore {
            let error: NSError
            func load() async throws -> Int {
                fatalError("should not be called")
            }
            
            func increase() async throws -> Int {
                throw error
            }
        }
        
        let storeStub = CounterStoreStub(error: anyError())
        let sut = CounterController(store: storeStub)
        
        await XCTAssertThrowsErrorAsync(try await sut.postIncrease()) { error in
            XCTAssertEqual(error as NSError, anyError())
        }
        
    }
    
    func anyError() -> NSError {
        NSError(domain: "any error", code: 0)
    }
}

import XCTest

func XCTAssertThrowsErrorAsync<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (_ error: Error) -> Void = { _ in }
) async {
    do {
        _ = try await expression()
        XCTFail("Expected error to be thrown, but no error was thrown. \(message())", file: file, line: line)
    } catch {
        errorHandler(error)
    }
}
