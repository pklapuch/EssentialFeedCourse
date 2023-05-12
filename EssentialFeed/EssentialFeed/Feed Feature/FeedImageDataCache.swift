//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 5/12/23.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
