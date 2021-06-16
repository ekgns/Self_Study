//
//  ViewController.swift
//  tableViewCell_In_collectionview
//
//  Created by 다훈김 on 2021/06/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testTableView.dataSource = self
        testTableView.delegate = self
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.update()
        return cell
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}


class TableViewCell: UITableViewCell {
    @IBOutlet weak var testCollView: UICollectionView!
    
    func update() {
        testCollView.dataSource = self
        testCollView.delegate = self
        
        }
    }

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionviewCell", for: indexPath) as! CollectionviewCell
        collCell.testLabel.text = "이게 되나?"
        return collCell
    }
    
    
}

extension TableViewCell: UICollectionViewDelegate {
    
}

extension TableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 350)
    }
}

class CollectionviewCell: UICollectionViewCell {
    @IBOutlet var testLabel: UILabel!
}
