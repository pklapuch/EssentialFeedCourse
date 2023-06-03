//
//  FeedEndpoint.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 6/3/23.
//

import Foundation

public enum FeedEndpoint {
    case get

    public func url(baseURL: URL) -> URL {
        switch self {
        case .get:
            return baseURL.appendingPathComponent("/v1/feed")
        }
    }
}
