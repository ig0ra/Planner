//
//  TaskDetailsController.swift
//  Planner
//
//  Created by Igor O on 13.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class TaskDetailsController: UIViewController, UITableViewDataSource, UITableViewDelegate, ActionResultDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var task:Task! //task for editing or creating the new one
    
    
//    fields for tasks
    var taskName:String?
    var taskInfo:String?
    var taskPriority:Priority?
    var taskCategory:Category?
    var taskDeadline:Date?
    
//    mark section who contains a certain data type
    let taskNameSection = 0
    let taskCategorySection = 1
    let taskPrioritySection = 2
    let taskDeadlineSection = 3
    let taskInfoSection = 4
    
    let dateFormatter = DateFormatter()
    
    var delegate: ActionResultDelegate!
    
    var textTaskName:UITextField!
    var textviewTaskInfo:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        if let task = task{ // если объект не пустой (значит режим редактирования, а не создания новой задачи)
            taskName = task.name
            taskInfo = task.info
            taskPriority = task.priority
            taskCategory = task.category
            taskDeadline = task.deadline
        }
    }
    
    //    Mark: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == taskInfoSection {
            return 120
        } else {
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case taskNameSection:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskName", for: indexPath) as? TaskNameCell else{
                fatalError("cell type")
            }
            
            // fill component from task
            cell.textTaskName.text = taskName
            
            textTaskName = cell.textTaskName
            
            return cell
            
            
        case taskCategorySection: // category
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskCategory", for: indexPath) as? TaskCategoryCell else{
                fatalError("cell type")
            }
            
            // content text for showing
            var value:String
            
            if let name = taskCategory?.name{
                value = name
            }else{
                value = "Not selected"
            }
            
            cell.labelTaskCategory.text = value
            
            
            return cell
            
            
        case taskPrioritySection: // priority
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskPriority", for: indexPath) as? TaskPriorityCell else{
                fatalError("cell type")
            }
            
            
            var value:String
            
            if let name = taskPriority?.name{
                value = name
            }else{
                value = "Not selected"
            }
            
            cell.labelTaskPriority.text = value
            
            
            return cell
            
        case taskDeadlineSection: // date
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskDeadline", for: indexPath) as? TaskDeadlineCell else{
                fatalError("cell type")
            }
            
            var value:String
            
            if let deadline = taskDeadline{
                value = dateFormatter.string(from: deadline)
            }else{
                value = "Not specified"
            }
            
            cell.labelTaskDeadline.text = value
            
            return cell
            
        case taskInfoSection: // description
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskInfo", for: indexPath) as? TaskInfoCell else{
                fatalError("cell type")
            }
            
            cell.textTaskInfo.text = taskInfo
            
            textviewTaskInfo = cell.textTaskInfo
            
            return cell
            
        default:
            fatalError("cell type")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case taskNameSection:
            return "Task"
        case taskCategorySection:
            return "Category"
        case taskPrioritySection:
            return "Priority"
        case taskDeadlineSection:
            return "Date"
        case taskInfoSection:
            return "Description"
        default:
            return ""
        }
    }


    
    //    MARK: IBActions
    
//    close controller without saving
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        task.name = textTaskName.text
        task.info = textviewTaskInfo.text
        task.category = taskCategory
        task.priority = taskPriority
        
        delegate.done(source: self, data: nil)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //    MARK: Prepare
    
    @IBAction func taskNameChanged(_ sender: UITextField) {
        taskName = sender.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nil {
            return
        }
        
        switch segue.identifier {
        case "SelectCategory":
            if let controller = segue.destination as? CategoryListController{
                controller.selectedItem = taskCategory
                controller.delegate = self
            }
        case "SelectPriority":
            if let controller = segue.destination as? PriorityListController{
                controller.selectedItem = taskPriority
                controller.delegate = self
            }
        
        default:
            return
        }
        
    }
    
    //    MARK: ActionResultDelegate
    
    func done(source: UIViewController, data: Any?){
        switch source {
        case is CategoryListController:
            taskCategory = data as? Category
            tableView.reloadRows(at: [IndexPath(row: 0, section: taskCategorySection)], with: .fade)
        case is PriorityListController:
            taskPriority = data as? Priority
            tableView.reloadRows(at: [IndexPath(row: 0, section: taskPrioritySection)], with: .fade)
        default:
            print()
        }
        
    }

}
