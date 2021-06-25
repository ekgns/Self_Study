//
//  HitVC.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/25.
//

import UIKit

class HitVC: UIViewController {
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        category.text = "인기 곡"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell2.nib(), forCellWithReuseIdentifier: CollectionViewCell2.identifier)
    }
    

}

extension HitVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell2.identifier, for: indexPath) as! CollectionViewCell2
        cell.cell2Thumnail.backgroundColor = .green
        cell.cell2Rank.setTitle("\(indexPath.row + 1)", for: .normal)
        cell.cell2Rank.setImage(UIImage(named: ""), for: .normal)
        cell.cell2Title.text = "제목"
        cell.cell2Artist.text = "가수"
        return cell
    }
    
    
}

extension HitVC: UICollectionViewDelegate {
    
}
