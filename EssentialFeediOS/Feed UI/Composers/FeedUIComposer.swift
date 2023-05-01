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
        let adapter = FeedLoaderPresentationAdapter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(delegate: adapter)
        let feedController = FeedViewController(refreshController: refreshController)
        
        adapter.presenter = FeedPresenter(
            feedView: FeedViewAdapter(adaptee: feedController, imageLoader: imageLoader),
            loadingView: WeakRefVirtualProxy(refreshController)
        )
        
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

private final class FeedLoaderPresentationAdapter: FeedRefreshViewControllerDelegate {
    private let feedLoader: FeedLoader
    var presenter: FeedPresenter?
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()
        
        feedLoader.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.presenter?.didFinishLoadingFeed(with: feed)
                
            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            }
        }
    }
}
