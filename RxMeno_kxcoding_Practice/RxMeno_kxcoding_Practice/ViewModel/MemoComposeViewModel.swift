//
//  MemoComposeViewModel.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxSwift
import RxCocoa
import Action

// 이 모델을 컴포즈에서 사용한다 컴포즈 씬은 새로운 메모를 추가할때 메모를 편집할떄 공통적으로 사용한다
class MemoComposeViewModel: CommonViewModel {
    // 컴포즈씬에 표시할 메모를 저장하는 속성을 선언한다
    private let content: String? // 새로운 메모를 추가할때는 nil이 저장되고 메모를 편집할때는 편집할 메모가 저장된다
    
    // 뷰에 바인딩 할 수 있도록 드라이버 추가
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    // 컴포즈 씬에선 저장과 취소 두가지를 구현한다
    // 액션을 저장하는 속성을 추가
    // 나중에 네비게이션바에 저장버튼과 취소 버튼을 추가할껀데 추가한 두 액션과 바인딩 할 것
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    // 뷰 모델에서 액션을 직접 구현 할 수 있지만 파라메터로 받고 있다
    // 뷰 모델에서 직접 구현하면 처리방식이 하나로 고정 반면 파라메터로 받으면 이전 화면에서 처리방식을 동적으로 결정할 수 있는 장점이 있다
    init(title: String, content: String? = nil, sceneCoordinator:
        SceneCoordinatorType, storage: MemoStorageType, saveAction: Action<String, // 액션을 받는 파라메터는 옵셔널로 선언 기본값이 닐로 선언
        Void>? = nil, cancelAction: CocoaAction? = nil) {
        self.content = content
        // 세이브 액션으로 전달된 액션을 그대로 저장하지않고 액션을 한번더 랩핑했다
        self.saveAction = Action<String, Void> { input in // 액션이 전달 되었다면 실제로 액션을 실행하고 화면을 닫는다
            if let action = saveAction {
                action.execute(input)
            }
            // 반대로 액션이 전달되지않았다면 화면만 닫히고 끝난다
            return sceneCoordinator.colse(animated: true).asObservable().map{ _ in }
        }
        
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoordinator.colse(animated: true).asObservable().map { _ in }
        }
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
