//
//  TaskListCell.swift
//  Planner
//
//  Created by Igor O on 10.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class TaskListCell: UITableViewCell {
    @IBOutlet weak var labelTaskName: UILabel!
    @IBOutlet weak var labelTaskCategory: UILabel!
    @IBOutlet weak var labelDeadline: UILabel!
    @IBOutlet weak var labelPriority: UILabel!
    @IBOutlet weak var buttonTaskInfo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
