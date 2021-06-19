//
//  StorageVC.swift
//  YouTubeMusic_clone
//
//  Created by 다훈김 on 2021/06/18.
//

import UIKit

class StorageVC: UIViewController {

    let contentImgs = ["Download", "Playlists", "Album", "Song","Artist","Subscription"]
    let contentNames = ["오프라인 저장 콘텐츠", "재생목록", "앨범", "노래", "아티스트", "구독"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension StorageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StorageListCell", for: indexPath) as! StorageListCell
        cell.contentBtn.setImage(UIImage(named: "\(contentImgs[indexPath.row]).png"), for: .normal)
        cell.contentBtn.setTitle(contentNames[indexPath.row], for: .normal)
        return cell
    }
    
    
}

extension StorageVC: UITableViewDelegate {
    
}

class StorageListCell: UITableViewCell {
    @IBOutlet weak var contentBtn: UIButton!
    
}
