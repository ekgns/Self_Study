//
//  TableViewCell.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "TableViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.thumnail.backgroundColor = .red
        cell.titleLabel.text = "제목입니다요"
        cell.artist.text = "가수입니다"
        
        
        return cell
    }
    
    
}


extension TableViewCell: UICollectionViewDelegate {
    
}

