//
//  TourVC.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/18.
//

import UIKit

class TourVC: UIViewController {
    let tableContentImgArr = ["new album", "chart", "smail"]
    let tabbleContentArr = ["새 앨범", "차트", "분위기 및 장르"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class TableviewCells: UITableViewCell {
    
    @IBOutlet weak var tourContent: UIButton!
    
}


extension TourVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabbleContentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableviewCells", for: indexPath) as! TableviewCells
        cell.tourContent.setImage(UIImage(named: "\(tableContentImgArr[indexPath.row]).png"), for: .normal)
        cell.tourContent.setTitle("\(tabbleContentArr[indexPath.row])", for: .normal)
        return cell
    }
    
    
}

extension TourVC: UITableViewDelegate {
    
}
