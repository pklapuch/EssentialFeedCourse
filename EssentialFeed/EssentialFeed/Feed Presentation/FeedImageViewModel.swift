//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 5/3/23.
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        return location != nil
    }
}
