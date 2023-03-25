//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Pawel Klapuch on 3/25/23.
//

import XCTest

class RemoteFeedLoader {
    init(client: HTTPClient) {
        
    }
}

class HTTPClient {
    private(set) var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader(client: client)

        XCTAssertNil(client.requestedURL)
    }
}
