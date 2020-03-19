//
//  CategoryListController.swift
//  Planner
//
//  Created by Igor O on 17.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class CategoryListController: DictionaryController<CategoryDaoDbImpl> {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictTableView = tableView
        dao = CategoryDaoDbImpl.current
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellCategory", for: indexPath) as? CategoryListCell else {
            fatalError("error with cell")
            
        }
        
        cell.selectionStyle = .none
        
        let category = dao.items[indexPath.row]
        
        if selectedItem != nil && selectedItem == category{
            cell.buttonCheckCategory.setImage(UIImage(named: "check_green"), for: .normal)
            currentCheckedIndexPath = indexPath
        } else {
            cell.buttonCheckCategory.setImage(UIImage(named: "check_gray"), for: .normal)
        }
        
        cell.labelCategoryName.text = category.name
        
        return cell
        
    }
    


    

    @IBAction func tapCheckCategory(_ sender: UIButton) {
        checkItem(sender)
    }
    

    // MARK: IBActions
    
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        cancel()
    }
    
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        save()
    }
    

}
