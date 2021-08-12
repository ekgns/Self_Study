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
//            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) {
//                row, memo, cell in
//                cell.textLabel?.text = memo.content
//            }
            .bind(to: listTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
        // 플러스 버튼과 액션을 바인딩한다
        addButton.rx.action = viewModel.makeCreateAction()
        
        // 디테일 뷰 모델 디테일 화면 전환 액션 바인딩 한다
        // 테이블 뷰에서 메모를 선택하면 뷰 모델을 통해 디테일 액션을 전달하고 선택한 셀은 선택해제 한다 -> 선택한 메모 필요하고 인덱스 패스가 필요
        // RxCoco는 선택 이벤트 처리에 사용하는 다양한 멤버를 extention으로 제공
        // 선택한 인덱스 패스가 필요할 때는 itemSelected를 사용하고
        // 선택한 데이터 (모델이 필요하다면) modelSelected 메서드를 사용
        
        // zip연산자로 두 멤버가 리턴하는 옵저버블을 병합한다
        Observable.zip(listTableView.rx.modelSelected(Memo.self), listTableView.rx.itemSelected) // 선택된 메모와 인덱스 패스가 튜플 형태로 방출된다
            .do(onNext: { [unowned self] (_, indexPath) in // do 연산자를 추가하고
                self.listTableView.deselectRow(at: indexPath, animated: true) // 넥스트 이벤트가 전달되면 선택 상태를 해제한다
            })
            .map { $0.0 } // 선택 상태를 처리 했기 때문에 이후에는 인덱스패스가 필요가 없다 맵연산자로 데이터만 방출하도록 변경
            .bind(to: viewModel.detailAction.inputs) // 전달된 메모를 디테일 액션과 바인딩한다
            .disposed(by: rx.disposeBag) // 선택한 메모가 액션으로 전달 되고 액션에 구현되어있는 코드가 실행된다 
        
        // 테이블 뷰에서 스와이프 투 딜리트 모드를 활성화 하고 삭제버튼과 액션을 바인딩해야한다
        listTableView.rx.modelDeleted(Memo.self)
            // 컨트롤 이벤트를 리턴 컨트롤 이벤트는 메모를 삭제할때마다 Next 이벤트를 방출
        // 컨트롤 이벤트를 딜리트 액션과 바인딩한다
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag) // 삭제와 관련된 컨트롤 이벤트를 구독하면 스와이프 투 딜리트가 자동 활성화 
        
    }
    // 데이터 소스 구현 없이 짧은 코드로 테이블 뷰의 데이터를 표시 할 수 있다
    // 셀을 재사용 큐에서 꺼내고 리턴하는 부분도 자동으로 처리
    // 클로져에서 셀 구성 코드만 구현 한면 된다 
    
    
    
}
