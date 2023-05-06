//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 5/6/23.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
