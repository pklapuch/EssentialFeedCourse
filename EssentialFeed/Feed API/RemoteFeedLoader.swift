//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 3/25/23.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                completion(Self.map(data, response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, _ resposne: HTTPURLResponse) -> Result {
        do {
            let items = try FeedItemsMapper.map(data, resposne)
            return .success(items)
        } catch {
            return .failure(Error.invalidData)
        }
    }
}
