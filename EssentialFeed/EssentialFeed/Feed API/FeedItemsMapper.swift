//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 4/8/23.
//

import Foundation

final class FeedItemsMapper {
    private struct Root: Decodable {
        private let items: [RemoteFeedItem]

        private struct RemoteFeedItem: Decodable {
            internal let id: UUID
            internal let description: String?
            internal let location: String?
            internal let imageURL: URL

            private enum CodingKeys: String, CodingKey {
                case id
                case description
                case location
                case imageURL = "image"
            }
        }

        var images: [FeedImage] {
            items.map {
                FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.imageURL)
            }
        }
    }
    
    private static var OK_200: Int { return 200 }
        
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedImage] {
        guard let root = try? JSONDecoder().decode(Root.self, from: data), response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.images
    }
}
