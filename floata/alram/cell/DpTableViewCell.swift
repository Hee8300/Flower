//
//  DpTableViewCell.swift
//  floting
//
//  Created by 홍태희 on 2021/11/02.
//

import UIKit

class DpTableViewCell: UITableViewCell {

    @IBOutlet weak var dpView: UIDatePicker?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
