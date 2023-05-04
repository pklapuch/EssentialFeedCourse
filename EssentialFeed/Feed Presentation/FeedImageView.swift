//
//  FeedImageView.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 5/3/23.
//

import Foundation

public protocol FeedImageView {
    associatedtype Image

    func display(_ model: FeedImageViewModel<Image>)
}
