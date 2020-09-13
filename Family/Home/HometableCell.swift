//
//  HometableCell.swift
//  Father
//
//  Created by Maher on 9/10/20.
//  Copyright © 2020 Maher. All rights reserved.
//

import UIKit

class HometableCell: UITableViewCell {
    
    @IBOutlet weak var childImg: UIImageView!
    @IBOutlet weak var childName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        childImg.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
