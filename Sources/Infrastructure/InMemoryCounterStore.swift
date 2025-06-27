// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

public class InMemoryCounterStore: CounterStore {
    private var counter = 0
    
    public init() {}
    
    public func load() async throws -> Int {
        counter
    }
    
    public func increase() async throws -> Int {
        counter += 1
        return counter
    }
    
    public func decrease() async throws -> Int {
        counter -= 1
        return counter
    }
}
