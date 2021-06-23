//
//  CollectionViewCell.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumnail: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var  artist: UILabel!
    
    
    static let identifier = "CollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }
    


}
