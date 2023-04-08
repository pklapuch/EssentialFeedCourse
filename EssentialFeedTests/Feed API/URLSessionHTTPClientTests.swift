import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        let request = URLRequest(url: url)
        session.dataTask(with: request, completionHandler: { _, _, _ in }).resume()
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
    
    func test_getFromURL_resumesDataTaskWithURL() {
        let url = URL(string: "https://a-url.com")!
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClient(session: session)
        
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        
        sut.get(from: url)
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    // MARK: - Helpers
    
    private class URLSessionSpy: URLSession {
        private(set) var receivedURLs = [URL]()
        private var stubs = [URL: URLSessionDataTask]()
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(request.url!)
            return stubs[request.url!] ?? FakeURLSessionDataTask()
        }
        
        func stub(url: URL, task: URLSessionDataTask) {
            stubs[url] = task
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() { }
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
        private(set) var resumeCallCount = 0
        
        override func resume() { resumeCallCount += 1 }
    }
}
