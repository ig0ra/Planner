//
//  TaskPriorityCell.swift
//  Planner
//
//  Created by Igor O on 13.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class TaskPriorityCell: UITableViewCell {
    @IBOutlet weak var labelTaskPriority: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
