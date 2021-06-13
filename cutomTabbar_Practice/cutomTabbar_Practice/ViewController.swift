//
//  ViewController.swift
//  cutomTabbar_Practice
//
//  Created by 다훈김 on 2021/06/13.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - properties
     
    let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        
        return cv
    }()
   
    // MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }


}

