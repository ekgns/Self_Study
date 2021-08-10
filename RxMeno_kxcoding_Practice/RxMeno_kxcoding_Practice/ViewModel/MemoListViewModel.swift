//
//  MemoListViewModel.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxSwift
import RxCocoa
import Action

// 메모 목록 테이블뷰와 바인딩할 수 있는 속성을 추가 해야한다
class MemoListViewModel: CommonViewModel {
    // 메모 배열을 방출 해야함
    // 메모목록 화면을 구성하고 뷰모델과 뷰를 바인딩 한다
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
    
    // 새 메모 추가, 수정
    func preformUpdate(memo: Memo) -> Action<String, Void> { //
        return Action { input in // 액션을 보면 입력타입은 스트링/  입력 값으로 메모를 업데이트하도록 구현
            // 크레이트 메모 메서드로 내용이 없는 메서드를 생성하고 실제로 저장하면 입력한 메모로 업데이트 하는 방식
            return self.storage.update(memo: memo, content: input).map { _ in } // 업데이트가 리턴하는 업져버블은 편집된 메모를 방출한다 옵져버블이 방출하는 타입은 보이드 방출한는 요소의 형식이 달라 컴파일 오류가 나지만 맵연산자를 통해 쉽게 해결가능
        }
    }
    
    // 취소
    func performCancel(memo: Memo) -> CocoaAction {
        // 이곳에서는 생성된 메모를 삭제한다
        // 취소 메서드에서 메모를 삭제하는 이유
        // 크리에이트 메모를 호출하면 메모가 실제로 생성되고 옵저버블로 방출된다 그래서 메모를 삭제하지않으면 불필요한 메모가 저장되고 테이블 뷰에 표시 된다
        return Action {
            return self.storage.delete(memo: memo).map{ _ in }
        }
    }
    
    // 쓰기 버튼을 누르면 모달로 표시 바인딩할 액션을 구현
    // 메서드 선언 리턴형을 코코 액션으로 선언
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "") // 크리에이트 메서드를 호출하면 새로운 메모가 생성되고 이 메모가 방출 되는 옵져버블이 리턴된다
                .flatMap{ memo -> Observable<Void> in // 플랫맵으연산자를 호출하고 클로저로 화면 전환을 처리
                    // 뷰 모델을 먼저 만들어야함 타이틀은 바로 문자열을 전달하면 되고 씬 코디네이터와 스토리지의 대한 의존성은 현재 뷰모델에 있는 속성으로 바로 주입할 수 있다
                    let composeViewModel = MemoComposeViewModel(title: "새 메모", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.preformUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    
                    // 컴포즈 씬을 생성하고 연관 값으로 뷰모델을 저장한다
                    let composeScene = Scene.compose(composeViewModel)
                    // 씬 코디네이터에서 트랜지션 메서드를 호출하고 씬을 모달 방식으로 표시
                    // 트랜지션 메서드는 컴플리터블을 리턴한다 맵 연산자로 보이드형식을 방출하는 옵저버블로바꿔줘야한다
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
                    
                    
                }
            }
        }
    // 목록화면에서 보기 화면으로 전환 구현
    // 다양한 코드를 보기 위해 속성형태로 구현
    // 클로저 내부에서 셀프에 접근해야하기 때문에 lazy선언
    lazy var detailAction: Action<Memo, Void> = {
        return Action { memo in
            // 뷰 모델 생성 후 씬을 생성한 다음 씬 코디네이터에서 트랜지션 메서드 호출
            // 목록화면에서 쓰기 화면으로 이동하는 것과 동일한 과정
            let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            
            let detailScene = Scene.detail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map { _ in }
        }
    }()
    
    // nav back button bind Action
    lazy var popAction = CocoaAction { [unowned self ] in
        return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in }
    }
}
