//
//  PriorityListController.swift
//  Planner
//
//  Created by Igor O on 18.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class PriorityListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let priorityDAO = PriorityDaoDbImpl.current
    
    var selectedPriority:Priority!
    
    //    Mark: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priorityDAO.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellPriority", for: indexPath) as? PriorityListCell else{
            fatalError("fatal error with cell")
        }
        
        let priority = priorityDAO.items[indexPath.row]
        
        if selectedPriority != nil && selectedPriority == priority{
            cell.buttonCheckPriority.setImage(UIImage(named: "check_green"), for: .normal)
        } else {
            cell.buttonCheckPriority.setImage(UIImage(named: "check_gray"), for: .normal)
        }
        
        cell.labelPriorityName.text = priority.name
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
