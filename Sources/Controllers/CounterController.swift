// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

public struct CounterController {
    private let store: CounterStore
    
    public init(store: CounterStore) {
        self.store = store
    }
    
    public func get() async throws -> String {
        let count = try await store.load()
        return CounterView(count: count).render()
    }
    
    public func postIncrease() async throws -> String {
        let count = try await store.increase()
        return CounterView(count: count).render()
    }
    
    public func postDecrease() async throws -> String {
        let count = try await store.decrease()
        return CounterView(count: count).render()
    }
}
