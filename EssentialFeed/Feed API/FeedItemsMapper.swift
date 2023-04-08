//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 4/8/23.
//

import Foundation

class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
        
        var feedItems: [FeedItem] {
            return items.map { $0.item }
        }
    }

    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let imageURL: URL
        
        private enum CodingKeys: String, CodingKey {
            case id
            case description
            case location
            case imageURL = "image"
        }
        
        var item: FeedItem {
            return .init(id: id,
                  description: description,
                  location: location,
                  imageURL: imageURL)
        }
    }
    
    private static var OK_200: Int { return 200 }
        
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.feedItems
    }
}
