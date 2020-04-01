//
//  QuickTaskCell.swift
//  Planner
//
//  Created by Igor O on 23.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class QuickTaskCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var textQuickTask: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textQuickTask.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textQuickTask.resignFirstResponder()
        return true
    }

}
