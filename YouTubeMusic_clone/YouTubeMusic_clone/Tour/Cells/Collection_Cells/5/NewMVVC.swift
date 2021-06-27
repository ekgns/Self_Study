//
//  NewMVVC.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/26.
//

import UIKit

class NewMVVC: UIViewController {
    @IBOutlet  weak var category: UILabel!
    @IBOutlet  weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        category.text = "새 뮤직 비디오"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell5.nib(), forCellWithReuseIdentifier: CollectionViewCell5.identifier)
        
    }
}

extension NewMVVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell5.identifier, for: indexPath) as! CollectionViewCell5
        cell.newMVImg.layer.cornerRadius = 5
        cell.newMVImg.backgroundColor = .red
        cell.newMVTitle.text = "블라블라"
        cell.newMVArtist.text = "누구·조회수 11만화"
        return cell
    }
    
    
}

extension NewMVVC: UICollectionViewDelegate {
    
}
