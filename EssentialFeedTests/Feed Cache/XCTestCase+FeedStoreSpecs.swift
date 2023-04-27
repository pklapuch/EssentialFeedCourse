//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Pawel Klapuch on 4/27/23.
//

import XCTest
import EssentialFeed

extension FeedStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: .empty, file: file, line: line)
    }
    
    @discardableResult
    func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
        let exp = expectation(description: "wait for cache insertion")
        var receivedError: Error?
        sut.insert(cache.feed, timestamp: cache.timestamp) { insertionError in
            receivedError = insertionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return receivedError
    }
    
    @discardableResult
    func delete(from sut: FeedStore, file: StaticString = #file, line: UInt = #line) -> Error? {
        let exp = expectation(description: "wait for completion")
        var receivedError: Error?
        
        sut.deleteCachedFeed { deletionError in
            receivedError = deletionError
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10.0)
        return receivedError
    }
    
    func expect(_ sut: FeedStore,
                        toRetrieveTwice expectedResult: RetrievedCachedFeedResult,
                        file: StaticString = #file,
                        line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult)
        expect(sut, toRetrieve: expectedResult)
    }
    
    func expect(_ sut: FeedStore,
                        toRetrieve expectedResult: RetrievedCachedFeedResult,
                        file: StaticString = #file,
                        line: UInt = #line) {
        let exp = expectation(description: "wait for completion")
        
        sut.retrieve { retrievedResult in
            switch (expectedResult, retrievedResult) {
            case (.empty, .empty), (.failure, .failure):
                break
                
            case let (.found(firstFeed, firstTimestamp), .found(secondFeed, secondTimestamp)):
                XCTAssertEqual(firstFeed, secondFeed)
                XCTAssertEqual(firstTimestamp, secondTimestamp)
            default:
                XCTFail("expected `\(expectedResult)`, but got \(retrievedResult)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
