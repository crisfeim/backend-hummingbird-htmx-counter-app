// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

protocol CounterStore {
    func load() async throws -> Int
    func increase() async throws -> Int
    func decrease() async throws -> Int
}
