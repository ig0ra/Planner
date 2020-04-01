//
//  PriorityListController.swift
//  Planner
//
//  Created by Igor O on 18.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class PriorityListController: DictionaryController<PriorityDaoDbImpl> {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictTableView = tableView
        dao = PriorityDaoDbImpl.current
        dao.getAll()
        
        dictTableView = tableView
        
        // Do any additional setup after loading the view.
    }
    
    //    Mark: TableView
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellPriority", for: indexPath) as? PriorityListCell else{
            fatalError("fatal error with cell")
        }
        
        cell.selectionStyle = .none
        
        let priority = dao.items[indexPath.row]
        
        if selectedItem != nil && selectedItem == priority{
            cell.buttonCheckPriority.setImage(UIImage(named: "check_green"), for: .normal)
            
            currentCheckedIndexPath = indexPath
        } else {
            cell.buttonCheckPriority.setImage(UIImage(named: "check_gray"), for: .normal)
        }
        
        cell.labelPriorityName.text = priority.name
        
        return cell
    }
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func tapCheckPriority(_ sender: UIButton) {
        checkItem(sender)
        
    }
    
    
    //    MARK: IBActions
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        cancel()
    }
    
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        save()
    }
}
