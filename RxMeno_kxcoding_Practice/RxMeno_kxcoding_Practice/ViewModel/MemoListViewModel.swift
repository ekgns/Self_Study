//
//  MemoListViewModel.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxSwift
import RxCocoa

// 메모 목록 테이블뷰와 바인딩할 수 있는 속성을 추가 해야한다
class MemoListViewModel: CommonViewModel {
    // 메모 배열을 방출 해야함
    // 메모목록 화면을 구성하고 뷰모델과 뷰를 바인딩 한다
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
    
}
