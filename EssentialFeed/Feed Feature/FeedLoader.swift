//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 3/25/23.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> ())
}
