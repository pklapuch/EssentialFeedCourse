import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        let request = URLRequest(url: url)
        session.dataTask(with: request, completionHandler: { _, _, _ in })
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    func test_getFromURL_createsDataTaskWithURL() {
        let url = URL(string: "https://a-url.com")!
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(from: url)
        XCTAssertEqual(session.receivedURLs, [url])
        
    }
    
    // MARK: - Helpers
    
    private class URLSessionSpy: URLSession {
        private(set) var receivedURLs = [URL]()
        
        override convenience init() {
            self.init()
        }
        
        override func dataTask(with request: URLRequest) -> URLSessionDataTask {
            receivedURLs.append(request.url!)
            return FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask { }
}
