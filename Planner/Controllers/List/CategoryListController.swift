//
//  CategoryListController.swift
//  Planner
//
//  Created by Igor O on 17.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class CategoryListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let categoryDao = CategoryDaoDbImpl.current
    
    var selectedCategory:Category!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDao.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellCategory", for: indexPath) as? CategoryListCell else {
            fatalError("error with cell")
        }
        
        let category = categoryDao.items[indexPath.row]
        
        if selectedCategory != nil && selectedCategory == category{
            cell.buttonCheckCategory.setImage(UIImage(named: "check_green"), for: .normal)
        } else {
            cell.buttonCheckCategory.setImage(UIImage(named: "check_gray"), for: .normal)
        }
        
        cell.labelCategoryName.text = category.name
        
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
