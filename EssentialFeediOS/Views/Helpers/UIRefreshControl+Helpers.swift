//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Pawel Klapuch on 5/3/23.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
