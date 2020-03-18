//
//  TaskDetailsController.swift
//  Planner
//
//  Created by Igor O on 13.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class TaskDetailsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    var task:Task! //task for editing
    
    var taskName:String?
    var taskInfo:String?
    var taskPriority:Priority?
    var taskCategory:Category?
    var taskDeadline:Date?
    
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
        if indexPath.section == 4 {
            return 120
        } else {
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section { // имя
        case 0:
            
            // получаем ссылку на ячейку
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskName", for: indexPath) as? TaskNameCell else{
                fatalError("cell type")
            }
            
            // заполняем компонент данными из задачи
            cell.textTaskName.text = taskName
            
            textTaskName = cell.textTaskName
            
            return cell
            
            
        case 1: // категория
            
            // получаем ссылку на ячейку
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskCategory", for: indexPath) as? TaskCategoryCell else{
                fatalError("cell type")
            }
            
            // будет хранить конечный текст для отображения
            var value:String
            
            if let name = taskCategory?.name{
                value = name
            }else{
                value = "Not selected"
            }
            
            // заполняем компонент данными из задачи
            cell.labelTaskCategory.text = value
            
            
            return cell
            
            
        case 2: // приоритет
            
            // получаем ссылку на ячейку
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskPriority", for: indexPath) as? TaskPriorityCell else{
                fatalError("cell type")
            }
            
            
            var value:String
            
            if let name = taskPriority?.name{
                value = name
            }else{
                value = "Not selected"
            }
            
            // заполняем компонент данными из задачи
            cell.labelTaskPriority.text = value
            
            
            return cell
            
        case 3: // дата
            
            // получаем ссылку на ячейку
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskDeadline", for: indexPath) as? TaskDeadlineCell else{
                fatalError("cell type")
            }
            
            var value:String
            
            if let deadline = taskDeadline{
                value = dateFormatter.string(from: deadline)
            }else{
                value = "Not specified"
            }
            
            // заполняем компонент данными из задачи
            cell.labelTaskDeadline.text = value
            
            return cell
            
        case 4: // доп. текстовая информация
            
            // получаем ссылку на ячейку
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTaskInfo", for: indexPath) as? TaskInfoCell else{
                fatalError("cell type")
            }
            
            // заполняем компонент данными из задачи
            cell.textTaskInfo.text = taskInfo
            
            textviewTaskInfo = cell.textTaskInfo
            
            return cell
            
        default:
            fatalError("cell type")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Task"
        case 1:
            return "Category"
        case 2:
            return "Priority"
        case 3:
            return "Date"
        case 4:
            return "Description"
        default:
            return ""
        }
    }


    
    //    Mark: IBActions
    
//    close controller without saving
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        task.name = textTaskName.text
        task.info = textviewTaskInfo.text
        
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
    
    //    Mark: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nil {
            return
        }
        
        switch segue.identifier {
        case "SelectCategory":
            if let controller = segue.destination as? CategoryListController{
                controller.selectedCategory = taskCategory
            }
        case "SelectPriority":
            if let controller = segue.destination as? PriorityListController{
                controller.selectedPriority = taskPriority
            }
        
        default:
            return
        }
        
    }

}
