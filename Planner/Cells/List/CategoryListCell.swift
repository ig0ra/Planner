//
//  CategoryListCell.swift
//  Planner
//
//  Created by Igor O on 17.03.20.
//  Copyright © 2020 Igor O. All rights reserved.
//

import UIKit

class CategoryListCell: UITableViewCell {
    @IBOutlet weak var labelCategoryName: UILabel!
    @IBOutlet weak var buttonCheckCategory: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
