//
//  MemoDetailViewModel.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: CommonViewModel {
    // 이전 씬에서 저장 된 메모가 전달됨
    let memo: Memo
    
    // 날짜를 문자열로 바꿀때 사용 하는 포멧터
    private var formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    // 메모내용은 테이블 뷰에 표시된다 첫 번째 셀에는 메모 내용 / 두 번째 셀 날짜 표시
    // 메모 목록에서 구현한 것처럼 테이블 뷰에 데이터를 표시할때는 옵저버블과 바인딩 한다 테이블 뷰에 표시할 데이터는 문자열 두 개 문자열 배열을 방출
    // why BehaviorSubject? : 메모를 편집하고 다시 보기 화면으로 되돌아 왔을때 편집한 내용 반영하기 위해 새로운 문자열 배열을 방출해야 한다 일반 옵저버블로 선언은 불가능 해서  BehaviorSubject 사용
    var contents: BehaviorSubject<[String]>
    
    // 생성자 추가 모든 속성 초기화
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType,
         storage: MemoStorageType) {
        self.memo = memo
        
        contents = BehaviorSubject<[String]>(value: [memo.content, formatter.string(from: memo.insertDate)])
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    // nav back button bind Action
    lazy var popAction = CocoaAction { [unowned self ] in
        return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in }
    }
}
