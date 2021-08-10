//
//  TransitionModel.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
// 전환과 관련된 열거형

enum TransitionStyle {
    case root // 루트 스타일
    case push // 푸쉬 스타일
    case modal // 모달 스타일
}

// 전환 에러
enum TransitionError: Error {
    case navigationControllerMissing // 네비게이션 미스
    case cannotPop // 팝업 안됨
    case unKnown // 알 수 없음
}
