//
//  TaskExtension.swift
//  Planner
//
//  Created by Igor O on 12.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation

extension Task {
    func daysLeft() -> Int! {
        if self.deadline == nil{
            return nil
        }
        
        return (self.deadline?.offsetFrom(date: Date().today))!
    }
}
