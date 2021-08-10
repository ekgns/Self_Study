//
//  SceneCoordinator.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxSwift
import RxCocoa

// 씬 코디네이터 프로토콜을 채용한 실제 씬 코디데이터를 구현
// 씬 코드네이터 클래스 선언하고 방금 선언한 씬 코드네이터 프로토콜 채용

class SceneCoordinator: SceneCoordinatorType {
    private let bag = DisposeBag() // 리소스 정리에 사용 구독 취소!
    
    // 씬 코디네이터는 화면 전환을 담당하기 때문에 윈도우 인스턴스와 현재 화면에 표시되는 씬을 가지고 있어야 한다
    private var  window: UIWindow
    private var currentVC: UIViewController
    
    // 두 속성을 초기화 하는 생성자를 추가
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool)
    -> Completable {
        // 전환 결과를 방출한 서브젝트 선언
        let subject = PublishSubject<Void>()
        
        // 씬을 생성해서 상수에 저장
        let target = scene.instantiate() // 씬 열거형에서 구현
        
        // 트랜지션 스타일에 따라서 실제 전환 처리
        switch style {
        case .root:
            currentVC = target
            window.rootViewController = target
            subject.onCompleted()
            
        case .push: // 푸쉬는 네비게이션 컨트롤러에 임베드 되있을 때 만 의미가 있다 임베드 여부 확인 후 임베드 되어있지 않다면 에러 이벤트를 전달하고 중지
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
             
            nav.pushViewController(target, animated: animated)
            currentVC = target
            
            subject.onCompleted()
            
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target
        }
        //이그노어엘리먼트 연산자를 호출해서 서브젝트를 리턴하면 커플리터블로 리턴됨
        return subject.ignoreElements()
    }
    
    @discardableResult
    func colse(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentedViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC
                    completable(.completed)
                }
            }else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.error(TransitionError.unKnown))
            }
            return Disposables.create()
        }
    }
}
