//
//  CommonViewModel.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//



// 뷰모델에는 크게 두 가지가 추가 의존성을 주입하는 생성자와 바인딩에 사용되는 속성과 메서드
// 뷰모델은 화면 전환과 메모 저장을 모두 처리 씬 코디네이터와 메모 스토리지 활용
// 뷰모델을 생성하는 시점에 생성자를 통해 의존성을 주입해야 한다 나머지 뷰 모델도 마찬가지
import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    // 앱을 구성하고 있는 모든 씬은 네비게이션 컨트롤러에 임배디드 되기 때문에 네비게이션 타이틀이 필요하다
    // 타이틀 속성을 추가하고 드라이버 형식으로 선언
    let title: Driver<String> // 네비게이션 아이템에 쉽게 바인딩 할 수 있다
    
    // 씬 코드네이터와 저장소를 저장하는 속성도 선언
    // 두 속성의 형식을 실제 형식이 아니라 프로토콜로 선언 이렇게 하면 의존성을 쉽게 수정 할 수 있다
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType
    
    // 속성을 초기화 하는 생성자 구현
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}

