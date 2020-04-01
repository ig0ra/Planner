//
//  TaskDAO.swift
//  Planner
//
//  Created by Igor O on 27.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation

protocol CommonSearchDAO: Crud {
    func search(text:String) -> [Item] 
}
