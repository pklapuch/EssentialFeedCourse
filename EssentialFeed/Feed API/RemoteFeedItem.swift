//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 4/19/23.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
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
