//
//  TextCellTableViewCell.swift
//  Numbered Notes
//
//  Created by McKlyde on 2/13/20.
//  Copyright © 2020 AdvancedLearningDynamics. All rights reserved.
//

import UIKit

class TextCellTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    var SongFileInfo: Songs? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
