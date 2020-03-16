//
//  DateExtension.swift
//  Planner
//
//  Created by Igor O on 12.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation

extension Date {
    var today: Date {
        return rewindDays(0)
    }
    
    func rewindDays (_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func offsetFrom(date: Date) -> Int {
        let calendar = Calendar.current
        
        
        let startOfCurrentDate = calendar.startOfDay(for: date)
        let startOfOtherDay = calendar.startOfDay(for: self)
        
        return calendar.dateComponents([.day], from: startOfOtherDay, to: startOfCurrentDate).day!
    }
}
