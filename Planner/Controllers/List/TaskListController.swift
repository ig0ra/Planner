//
//  TaskListController.swift
//  Planner
//
//  Created by Igor O on 09.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit
import CoreData

class TaskListController: UITableViewController, ActionResultDelegate {
    
    var taskList:[Task]!
    
    var delegate: ActionResultDelegate!
    
    let dateFormatter = DateFormatter()
    
    let taskDao = TaskDaoDbImpl.current
    let categoryDao = CategoryDaoDbImpl.current
    let priorityDao = PriorityDaoDbImpl.current

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        taskList = taskDao.getAll()
        }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as? TaskListCell else{
            fatalError("cell type")
        }
        
        let task = taskList[indexPath.row]
        
        cell.labelTaskName.text = task.name
        cell.labelTaskCategory.text = (task.category?.name ?? "")
        
//        color for priority
        if let priority = task.priority {
            
            switch priority.index {
            case 1:
                cell.labelPriority.backgroundColor = UIColor(named: "low")
            case 2:
                cell.labelPriority.backgroundColor = UIColor(named: "normal")
            case 3:
                cell.labelPriority.backgroundColor = UIColor(named: "high")
            default:
                cell.labelPriority.backgroundColor = UIColor.white
            }
        } else {
            cell.labelPriority.backgroundColor = UIColor.white
        }

        cell.labelDeadline.textColor = .lightGray
        
//       show notepad icon
        if task.info == nil || (task.info?.isEmpty)!{
            cell.buttonTaskInfo.isHidden = true
        } else {
            cell.buttonTaskInfo.isHidden = false
        }
        
//        text for showing number of days
        if let diff = task.daysLeft(){
            
            switch diff {
            case 0:
                cell.labelDeadline.text = "Today"
            case 1:
                cell.labelDeadline.text = "Tomorrow"
            case 0...:
                cell.labelDeadline.text = "\(diff) days"
            case ..<0:
                cell.labelDeadline.textColor = .red
                cell.labelDeadline.text = "\(diff) days"
                
            default:
                cell.labelDeadline.text = ""
            }
            
        }else{
            cell.labelDeadline.text = ""
        }
        
    
        
        
        return cell
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
//    delete task
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskDao.delete(taskList[indexPath.row])

            taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        } else if editingStyle == .insert {

        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        checking name of segue
        switch segue.identifier! {
        case "UpdateTask":
//            sender = cell type
            let selectedCell = sender as! TaskListCell
            
//            selected index
            let selectedIndex = (tableView.indexPath(for: selectedCell)?.row)!
            
//            selected task
            let selectedTask = taskDao.items[selectedIndex]
            
//            get access to controller
            guard let controller = segue.destination as? TaskDetailsController else {
                fatalError("error lol" )
            }
            
            controller.title = "Edit"
            controller.task = selectedTask
            controller.delegate = self
        default:
            return
        }
    }
    
    //    Mark: ActionResultDelegate
    
    func done(source: UIViewController, data: Any?) {
        if source is TaskDetailsController {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                taskDao.save()
                tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            }
        }
    }
    


}
