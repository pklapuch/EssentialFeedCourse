//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 3/25/23.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> ())
}
