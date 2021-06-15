//
//  ViewController.swift
//  CollectionView_In_TableView
//
//  Created by 다훈김 on 2021/06/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!
    
    var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        models.append(Model(text: "피카츄", imageName: "picachu"))
        models.append(Model(text: "파이리", imageName: "pairy"))
        models.append(Model(text: "꼬부기", imageName: "ggobook"))
        models.append(Model(text: "피존투", imageName: "pizon"))
        
    
        
        
        
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }
    
    
    
    


}

// 테이블
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        
        cell.configure(width: models)
        return cell
    }
    
    // 테이블 뷰 높이?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

class Model {
    let text: String
    let imageName: String
    
    init(text: String, imageName: String) {
        self.text = text
        self.imageName = imageName
    }
}
