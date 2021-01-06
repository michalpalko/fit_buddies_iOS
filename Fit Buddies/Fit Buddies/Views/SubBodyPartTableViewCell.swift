//
//  SubBodyPartTableViewCell.swift
//  Fit Buddies
//
//  Created by Michal Palko on 02/01/2021.
//

import UIKit

class SubBodyPartTableViewCell: UITableViewCell {
    @IBOutlet weak var subBodyPartImage: UIImageView!
    @IBOutlet weak var subBodyPartTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
