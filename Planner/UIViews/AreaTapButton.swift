//
//  AreaTapButton.swift
//  Planner
//
//  Created by Igor O on 20.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class AreaTapButton: UIButton {

    override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        let margin: CGFloat = 10
        let area = self.bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }

}
