//
//  TourVC.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/18.
//

import UIKit

class TourVC: UIViewController {
    @IBOutlet weak var tourTableView: UITableView!
    
    let ContentImgArr = ["new album", "chart", "smail"]
    let ContentArr = [" 새 앨범", " 차트", " 분위기 및 장르"]
    let categoryContent = ["새 앨범 및 싱글", "인기곡", "분위기 및 장르", "인기", "새 뮤직 비디오"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tourTableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        tourTableView.dataSource = self
        tourTableView.delegate = self
    }
}

class CollectionViewCells: UICollectionViewCell {
    
    @IBOutlet weak var tourContent: UIButton!
    
    
}


extension TourVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ContentArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCells", for: indexPath) as! CollectionViewCells
        cell.tourContent.setImage(UIImage(named: "\(ContentImgArr[indexPath.row]).png"), for: .normal)
        cell.tourContent.setTitle("\(ContentArr[indexPath.row])", for: .normal)
        print("\(ContentArr[indexPath.row])")
        return cell
    }
    
 
    
}

extension TourVC: UICollectionViewDelegate {
    
}

extension TourVC: UICollectionViewDelegateFlowLayout {
 

}

extension TourVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tourTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.categoryLabel.text = categoryContent[indexPath.row]
        return cell
    }
    
    
}

extension TourVC: UITableViewDelegate {
    
}
