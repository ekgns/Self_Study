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
    var memo: Memo
    
    // MARK: -날짜를 문자열로 바꿀때 사용 하는 포멧터
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
    
    //MARK: - 생성자 추가 모든 속성 초기화
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType,
         storage: MemoStorageType) {
        self.memo = memo
        
        contents = BehaviorSubject<[String]>(value: [memo.content, formatter.string(from: memo.insertDate)])
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    // MARK: -nav back button bind Action
    lazy var popAction = CocoaAction { [unowned self ] in
        return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in }
    }
    
    //MARK: - 새 메모 추가
    func preformUpdate(memo: Memo) -> Action<String, Void> { //
        return Action { input in // 액션을 보면 입력타입은 스트링/  입력 값으로 메모를 업데이트하도록 구현
                                 // 크레이트 메모 메서드로 내용이 없는 메서드를 생성하고 실제로 저장하면 입력한 메모로 업데이트 하는 방식
                                 // .map { _ in } // 업데이트가 리턴하는 업져버블은 편집된 메모를 방출한다 옵져버블이 방출하는 타입은 보이드 방출한는 요소의 형식이 달라 컴파일 오류가 나지만 맵연산자를 통해 쉽게 해결가능
             self.storage.update(memo: memo, content: input)
                .subscribe(onNext: { updated in
                    self.memo = updated
                    self.contents.onNext([
                        updated.content, self.formatter.string(from: updated.insertDate)
                    ])
                })
                .disposed(by: self.rx.disposeBag)
        return Observable.empty()
        }
    }
    
    // MARK: - 메모 수정
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(title: "메모편집", content: self.memo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.preformUpdate(memo: self.memo))
            
            let composeScene = Scene.compose(composeViewModel)
            
            return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map{ _ in }
        }
    }
    
    // MARK: - 메모 삭제
    // 삭제버튼과 바인딩할 액션 추가
    func makeDeleteAction() -> CocoaAction {
        return Action { input in
            self.storage.delete(memo: self.memo)
            return self.sceneCoordinator.close(animated: true).asObservable().map {
                _ in
            }
        }
    }

    
}
