//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 4/8/23.
//

import Foundation

final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
    private static var OK_200: Int { return 200 }
        
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard let root = try? JSONDecoder().decode(Root.self, from: data), response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.items
    }
}
