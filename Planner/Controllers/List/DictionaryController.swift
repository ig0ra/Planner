//
//  DictionaryController.swift
//  Planner
//
//  Created by Igor O on 19.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import Foundation
import UIKit

class DictionaryController<T:CommonSearchDAO>: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    var dictTableView: UITableView!
    
    var dao:T!
    
    var currentCheckedIndexPath:IndexPath!
    
    var selectedItem:T.Item!
    
    var delegate:ActionResultDelegate!
    
    var searchController:UISearchController!
    
    var searchBarText:String!
    
    var searchBar:UISearchBar{
        return searchController.searchBar
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        
        searchBar.searchBarStyle = .prominent
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

    //  MARK: search
    
    func setupSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        searchBar.delegate = self
        
        searchBar.showsCancelButton = false
        searchBar.setShowsCancelButton(false, animated: false)
        
        searchBar.searchBarStyle = .minimal
        
        searchController.hidesNavigationBarDuringPresentation = true
        
        if #available(iOS 11.0, *){
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            dictTableView.tableHeaderView = searchBar
        }
    }
    
    func searchBarShouldBeingEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = searchBarText
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchBar.placeholder = "Search"
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchBarText = ""
        dao.getAll()
        dictTableView.reloadData()
        searchBar.placeholder = "Search"
    }
    
    func updateSearchResults(for searchController: UISearchController){
        if !(searchBar.text?.isEmpty)!{
            searchBarText = searchBar.text!
            dao.search(text: searchBarText)
            dictTableView.reloadData()
            currentCheckedIndexPath = nil
            searchBar.placeholder = searchBarText
        }
    }

}
