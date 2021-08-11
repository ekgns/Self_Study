//
//  MemoDetailViewController.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import UIKit
import RxSwift
import RxCocoa


// 뷰와 뷰모델 바인딩
class MemoDetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoDetailViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var deleteButton: UIBarButtonItem! // 메모 삭제
    @IBOutlet weak var editButton: UIBarButtonItem! // 메모 편집
    @IBOutlet weak var shareButton: UIBarButtonItem! // 메모 공유

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func bindViewModel() {
        // navigation title binding
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.contents
            .bind(to: listTableView.rx.items) { tableview, row, value in
                switch row {
                case 0:
                    let cell = tableview.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableview.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: rx.disposeBag)
        
        deleteButton.rx.action = viewModel.makeDeleteAction() // 삭제 버튼
        editButton.rx.action = viewModel.makeEditAction() // 수정 버튼
//        // 뒤로가기 버튼 아이템
//        var backButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
//        viewModel.title // 뷰모델에 저장되있는 타이틀과 버튼 타이틀을 바인딩 타이틀이 드라이버형태로 제공 되기때문에 생성자로 전달할 수 없어 바인딩
//            .drive(backButton.rx.title)
//            .disposed(by: rx.disposeBag)
//        backButton.rx.action = viewModel.popAction
//        navigationItem.hidesBackButton = true
//        navigationItem.leftBarButtonItem = backButton // 기본으로 제공되는 백 버튼을 대체
        
        shareButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance) // 0.5초 마다 탭은 한번 씩만 전달 된다
            .subscribe(onNext: {[weak self] _ in
                guard let memo = self?.viewModel.memo.content else { return }

                let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
                self?.present(vc, animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
        
        
    }
    
    
}
