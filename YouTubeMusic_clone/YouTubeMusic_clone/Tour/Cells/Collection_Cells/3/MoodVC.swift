//
//  MoodVC.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/24.
//

import UIKit

class MoodVC: UIViewController {
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        category.text = "분위기 및 장르" 
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell3.nib(), forCellWithReuseIdentifier: CollectionViewCell3.identifier)
    }
}

extension MoodVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 33
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell3.identifier, for: indexPath) as! CollectionViewCell3
        return cell
    }
    
    
}

extension MoodVC: UICollectionViewDelegate {
    
}
