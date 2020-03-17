//
//  TaskDaoDblmpl.swift
//  Planner
//
//  Created by Igor O on 12.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//    implementation of DAO for tasks
class TaskDaoDbImpl: Crud {
    typealias Item = Task
    
    let categoryDao = CategoryDaoDbImpl.current
    let priorityDao = PriorityDaoDbImpl.current
    
    
    static let current = TaskDaoDbImpl()
    private init(){
        
    }
    
    var items: [Item]!
    
    //    Mark: DAO
    
    func getAll() -> [Item] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            items = try context.fetch(fetchRequest)
        } catch {
            fatalError("Fetching Failed")
        }
        
        return items
    }
    
    func delete(_ item: Item) {
        context.delete(item)
        
        save()
    }
    
    func addOrUpdate(_ item: Item) {
        if  !items.contains(item){
            items.append(item)
        }
        
        save()
    }
    
    
}
