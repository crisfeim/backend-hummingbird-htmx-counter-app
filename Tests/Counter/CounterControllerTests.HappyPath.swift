// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

import XCTest
import HummingBirdCounterApp

class CounterControllerHappyPathTests: XCTestCase {
    
    func test_get_deliversRenderedViewOnStoreSuccesfulRetrieval() async throws {
        struct CounterStoreStub: CounterStore {
            let result: Int
            func load() async throws -> Int {
               result
            }
            
            func increase() async throws -> Int {
                fatalError("shouldn't be invoked in this test")
            }
            
            func decrease() async throws -> Int {
                fatalError("shouldn't be invoked in this test")
            }
        }
        let storeStub = CounterStoreStub(result: 10)
        let sut = CounterController(store: storeStub)
        let renderedCount = try await sut.get()
        XCTAssertEqual(renderedCount, "<span>10</span>")
    }
    
    func test_postIncrease_deliversRenderedViewOnStoreSuccesfulRetrieval() async throws {
        struct CounterStoreStub: CounterStore {
            let result: Int
            func load() async throws -> Int {
                fatalError("shouldn't be invoked in this test")
            }
            
            func increase() async throws -> Int {
                result
            }
            
            func decrease() async throws -> Int {
                fatalError("shouldn't be invoked in this test")
            }
        }
        
        let storeStub = CounterStoreStub(result: 10)
        let sut = CounterController(store: storeStub)
        let renderedCount = try await sut.postIncrease()
        XCTAssertEqual(renderedCount, "<span>10</span>")
    }
    
    func anyError() -> NSError {
        NSError(domain: "any error", code: 0)
    }
}
