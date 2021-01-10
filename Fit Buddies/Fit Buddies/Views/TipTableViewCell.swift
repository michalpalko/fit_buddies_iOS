//
//  TipTableViewCell.swift
//  Fit Buddies
//
//  Created by Michal Palko on 09/01/2021.
//

import UIKit

class TipTableViewCell: UITableViewCell {

    @IBOutlet weak var insightImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
