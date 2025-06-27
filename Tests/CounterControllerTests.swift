// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.
import XCTest

class CounterControllerTests: XCTestCase {
    class CounterStoreSpy {
        var capturedMessages = [Any]()
    }
    struct CounterController {
        let store: CounterStoreSpy
    }
    
    func test_init_doesntMessageStore() {
        let storeSpy = CounterStoreSpy()
        let _ = CounterController(store: storeSpy)
        XCTAssertTrue(storeSpy.capturedMessages.isEmpty)
    }
}
