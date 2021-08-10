//
//  SceneCoordinatorType.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxSwift


// 프로토콜을 선언하고 씬 코디네이터가 공통적으로 구현해야하는 멤버를 선언
protocol SceneCoordinatorType { // 리턴형이 컴플리터블 구독자를 추가하고 화면 전환이 완료된 후에 원하는 작업을 구현할 수 있다
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable // 새로운 씬을 표시 파라메터로 대상 씬과 트렌지션스타일 애니메이션 플레그를 전달
    
    @discardableResult // 현재 씬을 닫고 이전 씬으로 돌아간다
    func colse(animated: Bool) -> Completable
}


