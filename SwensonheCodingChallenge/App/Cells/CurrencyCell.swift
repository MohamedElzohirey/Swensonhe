//
//  CurrencyCell.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/20/20.
//

import UIKit

class CurrencyCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel:UILabel!
    @IBOutlet weak var currencyValueLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
