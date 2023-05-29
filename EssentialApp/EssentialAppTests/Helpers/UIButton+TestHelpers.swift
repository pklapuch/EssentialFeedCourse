//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Pawel Klapuch on 5/1/23.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
