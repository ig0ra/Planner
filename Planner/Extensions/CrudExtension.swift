//
//  CrudExtension.swift
//  Planner
//
//  Created by Igor O on 12.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension Crud{
    var context:NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
//    saving all of the changes of context
    func save(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
