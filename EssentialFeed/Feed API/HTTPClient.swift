//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 4/8/23.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
