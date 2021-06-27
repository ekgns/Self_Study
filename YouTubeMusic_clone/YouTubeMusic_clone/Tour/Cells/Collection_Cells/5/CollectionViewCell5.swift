//
//  CollectionViewCell5.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/26.
//

import UIKit

class CollectionViewCell5: UICollectionViewCell {
    @IBOutlet weak var newMVImg: UIImageView!
    @IBOutlet weak var newMVTitle: UILabel!
    @IBOutlet weak var newMVArtist: UILabel!
    
    static let identifier = "CollectionViewCell5"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell5", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
