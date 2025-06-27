// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

struct CounterController {
    let store: CounterStore
    
    func get() async throws -> Int {
        try await store.load()
    }
    
    func postIncrease() async throws -> Int {
        try await store.increase()
    }
    
    func postDecrease() async throws -> Int {
        try await store.decrease()
    }
}
