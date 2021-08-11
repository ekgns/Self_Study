//
//  SceneCoordinator.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController { // 실제로 화면에 표시되어 있는 뷰 컨트롤러를 리턴하는 속성을 추가한다
    var sceneViewController: UIViewController {
        return self.children.first ?? self // 네비게이션 컨트롤러와 같은 컨테이너 뷰 컨트롤러라면 마지막 차일드를 리턴하고 나머지 경우에는 셀프를 리턴
    }
}

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
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) // 파라메터로 전달 한 씬은 열거형일 뿐
    -> Completable {
        // 전환 결과를 방출한 서브젝트 선언
        let subject = PublishSubject<Void>()
        
        // 씬을 생성해서 상수에 저장
        let target = scene.instantiate() // 여기서 전달 된 씬을 실제로 생성 
        
        // 트랜지션 스타일에 따라서 실제 전환 처리
        switch style {
        case .root: // 트랜지션으로 전달된 스타일이 루트이 이기 때문에 여기가 실행 된다
            currentVC = target.sceneViewController
            window.rootViewController = target // 앞에서 생성된 씬을 루트 뷰 컨트롤러로 지정하고 있다
            subject.onCompleted() // 목록 화면을 임베드 하고있는 컨트롤러가 화면에 표시 되고있다 
            
        case .push: // 푸쉬는 네비게이션 컨트롤러에 임베드 되있을 때 만 의미가 있다 임베드 여부 확인 후 임베드 되어있지 않다면 에러 이벤트를 전달하고 중지
            print(currentVC)
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.rx.willShow
                .subscribe(onNext: { [unowned self ] evt in
                    self.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: bag)
             
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
            
            subject.onCompleted()
            
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
        }
        //이그노어엘리먼트 연산자를 호출해서 서브젝트를 리턴하면 커플리터블로 리턴됨
        return subject.ignoreElements()
    }
    
    @discardableResult 
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) { // 뷰 컨트롤러가 모달 방식으로 표시 되어 있다면 현재 씬을 디스미스 한다
                    self.currentVC = presentingVC.sceneViewController
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
