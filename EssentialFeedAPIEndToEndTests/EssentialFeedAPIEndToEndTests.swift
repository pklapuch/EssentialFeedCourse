//
//  EssentialFeedAPIEndToEndTests.swift
//  EssentialFeedAPIEndToEndTests
//
//  Created by Pawel Klapuch on 4/17/23.
//

import XCTest
import EssentialFeed

final class EssentialFeedAPIEndToEndTests: XCTestCase {
    
    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        let testServerURL = URL(string: "https://essentialdeveloper.com/feed-case-study/test-api/feed")!
        let session = URLSession(configuration: .ephemeral)
        let client = URLSessionHTTPClient(session: session)
        let loader = RemoteFeedLoader(url: testServerURL, client: client)
        
        trackForMemoryLeaks(client)
        trackForMemoryLeaks(loader)
        
        let exp = expectation(description: "wait for completion")
        var receivedResult: FeedLoader.Result?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 20.0)
        
        switch receivedResult {
        case let .success(feed):
            XCTAssertEqual(feed.count, 8, "expected 8 items in the test account feed")
        case let .failure(error):
            XCTFail("expected success, got error: \(error)")
        case .none:
            XCTFail("expected success, got no result")
        }
    }
}
