//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Pawel Klapuch on 3/25/23.
//

import XCTest
import EssentialFeed

final class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, spy) = makeSUT()

        XCTAssertEqual(spy.requestedURLs, [])
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, spy) = makeSUT(url: url)
        
        sut.load()

        XCTAssertEqual(spy.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, spy) = makeSUT(url: url)
        
        sut.load()
        sut.load()

        XCTAssertEqual(spy.requestedURLs, [url, url])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-given-url.com")!) -> (RemoteFeedLoader, HTTPClientSpy) {
        let spy = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: spy)
        
        return (sut, spy)
    }
    
    class HTTPClientSpy: HTTPClient {
        private(set) var requestedURLs = [URL]()
        
        func get(from url: URL) {
            requestedURLs.append(url)
        }
    }
}
