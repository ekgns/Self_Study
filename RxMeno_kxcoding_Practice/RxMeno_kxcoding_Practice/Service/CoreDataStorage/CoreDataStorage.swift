//
//  CoreDataStorage.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/12.
//

import Foundation
import RxSwift
import RxCoreData
import CoreData

class CoreDataStorage: MemoStorageType {
    let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // CRUD
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content) // 새로운 메모 인스턴스 생성b
        do {
            _ = try mainContext.rx.update(memo) // 새로운 메모를 추가할 때 는 업데이트 메서드를 사용 업데이트 메서드는 어설트 방식으로 동작 파라메터로 전달한 메모가 이미 저장되어있다면 업데이트하고 없다면 새롭게 추가
            // 메모가 정상적으로 추가 되었다면 옵저버블을 통해 방출
            return Observable.just(memo)
        }catch { // 전달 된 에러를 그대로 방출
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        // 메모 목록 리턴
        // 코어 데이터로 구현하면 패치 리퀘스트를 생성해야한다 RxCoreDate에서는 하나의 메서드로 끝남
        // 첫 번째 파라미터 메모의 타입 = 코어 데이터에 저장된 데이터가 메모 인스턴스로 리턴
        // 두 번째 파라미터 프리디케이트를 전달 = 여기선 생량
        // 마지막 파라미터 소트 파라미터 = 날짜를 내림차순으로 정렬
        return mainContext.rx.entities(Memo.self, sortDescriptors: [NSSortDescriptor(key: "insertDate", ascending: false)])
            .map { results in [MemoSectionModel(model: 0, items: results)] }  // entity 메서드는 Observable을 리턴하고 Observable방출하는 요소의 형식은 첫 번째 파라미터로 전달한 형식의 배열 그런데 메모리스트가 리턴하는 Observable MemoSectionModel 배열을 방출해야함 map 연산자를 활용해 MemoSectionModel로 변환
    }
    
    @discardableResult
    // MARK: - 업데이트
    func update(memo: Memo, content: String) -> Observable<Memo> {
        // 메모 인스턴스와 변경된 내용이 파라미터로 전달
        // 메모가 구조체로 선언되 있고 파라미터는 기본적으로 상수 memo.content 형식을 사용할 수 없음 변경된 내용을 기반으로 새로운 인스턴스 생성
        let updated = Memo(original: memo, updateContent: content)
        
        do {
            _ = try mainContext.rx.update(updated)
            return Observable.just(updated)
        } catch {
            return Observable.error(error)
        }
        
    }
    
    @discardableResult
    // MARK: - 삭제
    func delete(memo: Memo) -> Observable<Memo> {
        do {
            try mainContext.rx.delete(memo)
            return Observable.just(memo)
        }catch {
            return Observable.error(error)
        }
    }
    
    
}
