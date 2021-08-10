//
//  MemoListViewController.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MemoListViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    // RxSwift에서는 RxCocos가 추가한 탭 속성을 구독하고 액션 속성에 직접액션을 할당하는 방식으로 구현한다
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindViewModel() { // 뷰 모델과 뷰를 바인딩 한다
    // 뷰 모델에 저장되어있는 타이틀을 네비게이션 타이틀과 바인딩 한다
        viewModel.title // 뷰모델에 저장된 타이틀이 네비게이션 바에 표시 된다
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        // 메모 목록을 테이블 뷰에 바인딩 하면 끝
        // 옵져버블과 테이블 뷰를 바인딩 하는 방식으로 구현한다
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) {
                row, memo, cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
    } // 데이터 소스 구현 없이 짧은 코드로 테이블 뷰의 데이터를 표시 할 수 있다
    // 셀을 재사용 큐에서 꺼내고 리턴하는 부분도 자동으로 처리
    // 클로져에서 셀 구성 코드만 구현 한면 된다 

}
