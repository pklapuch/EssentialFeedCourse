//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Pawel Klapuch on 6/3/23.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
