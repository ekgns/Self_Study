//
//  CollectionViewCell2.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/23.
//

import UIKit

class CollectionViewCell2: UICollectionViewCell {
    @IBOutlet weak var cell2Thumnail: UIImageView!
    @IBOutlet weak var cell2Rank: UIButton!
    @IBOutlet weak var cell2Title: UILabel!
    @IBOutlet weak var cell2Artist: UILabel!
    
    static let identifier = "CollectionViewCell2"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell2", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
