//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Pawel Klapuch on 5/1/23.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
