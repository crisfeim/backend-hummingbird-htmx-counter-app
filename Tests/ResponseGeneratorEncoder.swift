// © 2025  Cristian Felipe Patiño Rojas. Created on 27/6/25.


import Hummingbird
import HummingBirdCounterApp

enum ResponseGeneratorEncoder {
    static func execute(_ html: String, from request: Request, context: some RequestContext) throws -> Response {
        var buffer = ByteBufferAllocator().buffer(capacity: html.utf8.count)
        buffer.writeString(html)
        
        var headers = HTTPFields()
        headers.reserveCapacity(2)
        headers.append(.init(name: .contentType, value: "text/html; charset=utf-8"))
        headers.append(.init(name: .contentLength, value: buffer.readableBytes.description))
        
        return Response(
            status: .ok,
            headers: headers,
            body: .init(byteBuffer: buffer)
        )
    }
}
