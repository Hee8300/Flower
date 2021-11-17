//
//  AlarmTableViewCell.swift
//  floting
//
//  Created by 홍태희 on 2021/11/03.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reAlarmCell: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
