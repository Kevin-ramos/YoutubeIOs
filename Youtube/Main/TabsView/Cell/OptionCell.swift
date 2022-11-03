//
//  OptionCell.swift
//  Youtube
//
//  Created by user228543 on 10/14/22.
//

import UIKit

class OptionCell: UICollectionViewCell {

    @IBOutlet weak var tittleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(option: String){
        tittleLabel.text = option
    }
    
}
