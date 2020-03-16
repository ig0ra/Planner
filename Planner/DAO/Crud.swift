//
//  Crud.swift
//  Planner
//
//  Created by Igor O on 12.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation
import CoreData


//  API for entities
protocol Crud {
    associatedtype Item: NSManagedObject // add object to DB
    
    var items:[Item]! { get set }
    
    func addOrUpdate(_ item: Item)
    
    func getAll() -> [Item]
    
    func delete(_ item: Item)
}
