// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Hummingbird

@main
struct HummingBirdCounterApp: ParsableCommand {
    @Option(name: .shortAndLong)
    var hostname: String = "127.0.0.1"
    
    @Option(name: .shortAndLong)
    var port: Int = 8080
    
    func run() async throws {
        let store = InMemoryCounterStore()
        let config = ApplicationConfiguration(address: .hostname(self.hostname, port: self.port), serverName: "Hummingbird")
        return try await AppComposer.execute(with: config, store: store).runService()
    }
}
