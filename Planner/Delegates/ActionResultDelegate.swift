//
//  ActionResultDelegate.swift
//  Planner
//
//  Created by Igor O on 14.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation
import UIKit

protocol ActionResultDelegate {
    func done(source: UIViewController, data: Any?)
    func cancel(source: UIViewController, data: Any?)
}
    
    extension ActionResultDelegate {
        func done(source: UIViewController, data: Any?) {
            fatalError("not implemented")
        }
        func cancel(source: UIViewController, data: Any?) {
            fatalError("not implemented")
        }
}
