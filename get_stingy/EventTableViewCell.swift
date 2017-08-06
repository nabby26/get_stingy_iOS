//
//  EventTableViewCell.swift
//  get_stingy
//
//  Created by Nabila on 05/08/2017.
//  Copyright © 2017 Nabila Herzegovina. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
	@IBOutlet weak var cellTitle: UILabel!
	@IBOutlet weak var happeningNowLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
			happeningNowLabel.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
