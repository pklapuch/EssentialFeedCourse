//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Pawel Klapuch on 4/30/23.
//

import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() { }
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(loadFeed: presenter.loadFeed)
        let feedController = FeedViewController(refreshController: refreshController)
        let feedViewAdapter = FeedViewAdapter(adaptee: feedController, imageLoader: imageLoader)
        
        presenter.loadingView = WeakRefVirtualProxy(refreshController)
        presenter.feedView = feedViewAdapter
        
        return feedController
    }
}

private final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: FeedLoadingView where T: FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel) {
        object?.display(viewModel)
    }
}

private final class FeedViewAdapter: FeedView {
    private weak var adaptee: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(adaptee: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.adaptee = adaptee
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        adaptee?.tableModel = viewModel.feed.map { model in
            let viewModel = FeedImageViewModel<UIImage>(model: model, imageLoader: imageLoader, imageTransformer: UIImage.init)
            return FeedImageCellController(viewModel: viewModel)
        }
    }
}
