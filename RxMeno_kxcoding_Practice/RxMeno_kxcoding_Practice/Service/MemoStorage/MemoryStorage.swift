//
//  MemoryStorage.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {

    // 메모리에 메모를 저장
    private var list = [
        Memo(content: "Hello RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
    ]
    /* RxDataSource 사용전
     클래스 외부에서 배열에 직접 접근할 필요가 없기 때문에 private로 선언
     배열을 Observable을 통해 외부로 공개 Observable은 배열의 상태가 Update되면 새로운 Next 이벤트 방출 해야함
     그냥 Observable로 만들면 불가능 그래서 서브젝트로 만들어야함 초기의 더미 데이터 표시해야하니
     BehaviorSubject로 만든다
     기본값을 리스트배열로 선언하기위해 lazy로 선언했고 서브젝트도 외부에서 직접접근 할 필요 없기 떄문에 private로 선언
     private lazy var store = BehaviorSubject<[Memo]>(value: list) // BehaviorSubject 메모 배열 방출
     List기반으로 새로운 SectionModel을 만든다
     */
    
    private lazy var sectionModel = MemoSectionModel(model: 0, items: list)
    private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel]) // BehaviorSubject 섹션 모델 배열 방출
    
    @discardableResult
    /*
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        store.onNext(list)
        return Observable.just(memo)
    }
    */
    
    // 대상 배열을 바꾸고 SectionModel을 배출하도록 한다
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        sectionModel.items.insert(memo, at: 0)
        
        store.onNext([sectionModel])
        return Observable.just(memo)
    }
    
    @discardableResult
    /*
    // 메모 배열 방출
    func memoList() -> Observable<[Memo]> {
        return store
    }
    */
    func memoList() -> Observable<[MemoSectionModel]> { // 메모 섹션 모델 방출
        return store
    }
    
    @discardableResult
    /* Update는 Create와 마찬가지로 대상 배열을 바꿔야함
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updateContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
        
    }
     */
    
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updateContent: content)
        
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
            sectionModel.items.insert(updated, at: index)
        }
        store.onNext([sectionModel])
    
        return Observable.just(updated)
    }
    
    @discardableResult
   /*
     func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: {$0 == memo}) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        return Observable.just(memo)
    }
     */
    func delete(memo: Memo) -> Observable<Memo> {
       if let index = sectionModel.items.firstIndex(where: {$0 == memo}) {
        sectionModel.items.remove(at: index)
       }
       
       store.onNext([sectionModel])
       return Observable.just(memo)
   }
    
    
}
