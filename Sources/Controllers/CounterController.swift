// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

public struct CounterController {
    private let store: CounterStore
    
    public init(store: CounterStore) {
        self.store = store
    }
    
    public func get() async throws -> Int {
        try await store.load()
    }
    
    public func postIncrease() async throws -> Int {
        try await store.increase()
    }
    
    public func postDecrease() async throws -> Int {
        try await store.decrease()
    }
}
