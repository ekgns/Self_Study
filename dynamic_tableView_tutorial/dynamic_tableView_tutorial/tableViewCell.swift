//
//  tableViewCell.swift
//  dynamic_tableView_tutorial
//
//  Created by 다훈김 on 2021/06/14.
//

import Foundation
import UIKit

class tableViewCell: UITableViewCell {
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var userContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("tableViewCell - awakeFromNib() called")
        // 동그라미
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width / 2
    }
    
    
    
}
