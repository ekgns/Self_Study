//
//  TableViewCell.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/22.
//

import UIKit

class NewAlbumVC: UIViewController {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = "새 앨범 및 싱글"
        
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension NewAlbumVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.thumnail.backgroundColor = .red
        cell.thumnail.layer.cornerRadius = 5
        cell.titleLabel.text = "제목입니다요"
        cell.artist.text = "가수입니다"
        return cell
        
    }
    
    
}


extension NewAlbumVC: UICollectionViewDelegate {
    
}

