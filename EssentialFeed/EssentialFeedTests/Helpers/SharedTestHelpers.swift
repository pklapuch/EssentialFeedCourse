//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Pawel Klapuch on 4/23/23.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 1)
}

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}
