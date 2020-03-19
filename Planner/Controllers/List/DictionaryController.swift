//
//  DictionaryController.swift
//  Planner
//
//  Created by Igor O on 19.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation
import UIKit

class DictionaryController<T:Crud>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dictTableView: UITableView!
    
    var dao:T!
    
    var currentCheckedIndexPath:IndexPath!
    
    var selectedItem:T.Item!
    
    var delegate:ActionResultDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //    MARK: tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("not implemented")
    }
    
    func checkItem(_ sender:UIView){
        let viewPosition = sender.convert(CGPoint.zero, to: dictTableView)
        let indexPath = dictTableView.indexPathForRow(at: viewPosition)!
        
        let item = dao.items[indexPath.row]
        
        if indexPath != currentCheckedIndexPath{
            
            selectedItem = item
            
            if let currentCheckedIndexPath = currentCheckedIndexPath{
            
            dictTableView.reloadRows(at: [currentCheckedIndexPath], with: .none)
            }
            
            currentCheckedIndexPath = indexPath
    } else {
        selectedItem = nil
        currentCheckedIndexPath = indexPath
    }
    dictTableView.reloadRows(at: [indexPath], with: .none)
}
    
    
    //    MARK: dao
    func cancel(){
        navigationController?.popViewController(animated: true)
    }
    
    func save () {
        cancel()
        
        delegate?.done(source: self, data: selectedItem)
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
