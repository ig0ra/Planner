//
//  PriorityListCell.swift
//  Planner
//
//  Created by Igor O on 18.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class PriorityListCell: UITableViewCell {
    @IBOutlet weak var labelPriorityName: UILabel!
    
    @IBOutlet weak var buttonCheckPriority: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
