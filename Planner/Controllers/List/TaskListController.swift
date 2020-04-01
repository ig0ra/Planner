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
    
    var delegate: ActionResultDelegate!
    
    let dateFormatter = DateFormatter()
    
    let taskDao = TaskDaoDbImpl.current
    let categoryDao = CategoryDaoDbImpl.current
    let priorityDao = PriorityDaoDbImpl.current
    
    var searchController:UISearchController! // search bar
    
    let quickTaskSection = 0
    let taskListSection = 1
    let sectionCount = 2
    
    var textQuickTask:UITextField!
    
    var taskCount:Int{
        return taskDao.items.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        setupSearchController()
        }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case quickTaskSection:
            return 1
        case taskListSection:
            return taskCount
        default:
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case quickTaskSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellQuickTask", for: indexPath) as? QuickTaskCell else {
                fatalError("error with cell")
            }
            textQuickTask = cell.textQuickTask
            textQuickTask.placeholder = "Enter task name"
            
            return cell
        
        case taskListSection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as? TaskListCell else{
            fatalError("cell type")
        }
        
        let task = taskDao.items[indexPath.row]
        
        cell.labelTaskName.text = task.name
        cell.labelTaskCategory.text = (task.category?.name ?? "no category")
            
        
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
        
        //    completed style
        
        if task.completed{
            cell.labelDeadline.textColor = .lightGray
            cell.labelTaskName.textColor = .lightGray
            cell.labelTaskCategory.textColor = .lightGray
            cell.labelPriority.backgroundColor = .lightGray
            
            cell.buttonCompleteTask.setImage(UIImage(named: "check_green"), for: .normal)
            
            cell.selectionStyle = .none
            
            cell.buttonTaskInfo.isEnabled = false
            
            cell.buttonTaskInfo.imageView?.image = UIImage(named: "note_gray")
        } else { // uncompleted style
            cell.selectionStyle = .default
            cell.buttonTaskInfo.isEnabled = true
            cell.buttonTaskInfo.imageView?.image = UIImage(named: "note")
            cell.labelTaskName.textColor = .darkGray
            cell.buttonCompleteTask.setImage(UIImage(named: "check_gray"), for: .normal)
            cell.buttonTaskInfo.isEnabled = true
        }
        
        return cell
        
        default: return UITableViewCell()
        }
        
    }
    



    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case quickTaskSection:
            return 45
        default:
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == quickTaskSection{
            return false
        }
        return true
    }
    
//    delete task
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(indexPath)
        } else if editingStyle == .insert {

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if taskDao.items[indexPath.row].completed == true{
            return
        }
        
        if indexPath.section != quickTaskSection{
        performSegue(withIdentifier: "UpdateTask", sender: tableView.cellForRow(at: indexPath))
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
        case "CreateTask":
            guard let controller = segue.destination as? TaskDetailsController
                else { fatalError ("sup bro it`s error") }
            
            controller.title = "New task"
            controller.task = Task(context: taskDao.context)
            controller.delegate = self
        default:
            return
        }
    }
    
    //    MARK: ActionResultDelegate
    
    func done(source: UIViewController, data: Any?) {
        if source is TaskDetailsController {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                taskDao.save()
                tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            } else {
                let task = data as! Task
                
                createTask(task)
            }
        }
    }
    
    //    MARK: Actions
    @IBAction func tapCompleteTask(_ sender: UIButton) {
        let viewPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = self.tableView.indexPathForRow(at: viewPosition)!
        
        completeTask(indexPath)
    }
    
    func completeTask(_ indexPath: IndexPath){
        guard (tableView.cellForRow(at: indexPath) as? TaskListCell) != nil else {
            fatalError()
        }
        
        let task = taskDao.items[indexPath.row]
        
        task.completed = !task.completed
        
        taskDao.addOrUpdate(task)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    @IBAction func completeFromTaskDetails(segue: UIStoryboardSegue){
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            completeTask(selectedIndexPath)
        }
    }
    
    @IBAction func deleteFromTaskDetails(segue: UIStoryboardSegue){
        guard segue.source is TaskDetailsController else {
            fatalError()
        }
        
        if segue.identifier == "DeleteTaskFromDetails", let selectedIndexPath = tableView.indexPathForSelectedRow{
            deleteTask(selectedIndexPath)
        }
    }
    
    @IBAction func tapCreateTask(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "CreateTask", sender: tableView)
    }
    
    @IBAction func quickTaskAdd(_ sender: UITextField) {
        var task = Task(context: taskDao.context)
        
        if let name = textQuickTask.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty{
            task.name = name
        } else {
            task.name = "New task"
        }
        createTask(task)
        
        textQuickTask.text = ""
    }
    
    func createTask (_ task: Task) {
        taskDao.addOrUpdate(task)
        let indexPath = IndexPath(row: taskCount-1, section: taskListSection)
        
        tableView.insertRows(at: [indexPath], with: .bottom)
    }
    //    MARK: DAO
    
    func deleteTask (_ indexPath: IndexPath) {
        let task = taskDao.items[indexPath.row]
        taskDao.delete(task)
        taskDao.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .top)
    }
    
}

extension TaskListController: UISearchBarDelegate{
    
    //        add search bar to table
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        
        searchController.searchBar.placeholder = "Search by name"
        searchController.searchBar.backgroundColor = .white
        
        searchController.searchBar.showsScopeBar = false
        
        searchController.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !(searchController.searchBar.text?.isEmpty)!{
            taskDao.search(text: searchController.searchBar.text!)
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        taskDao.getAll()
        tableView.reloadData()
    }
}
