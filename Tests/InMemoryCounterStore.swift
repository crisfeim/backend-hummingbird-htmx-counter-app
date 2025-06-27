// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.

import HummingBirdCounterApp

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
