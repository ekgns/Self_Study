//
//  Memo.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxDataSources // 테이블 뷰와 콜렉션뷰에 바인딩 될 수 있는 DataSource를 제공한다
// DataSource에 저장되는 모든 데이터는 반드시 IdentifiableType 프로토콜을 채용해야한다
import CoreData
import RxCoreData



struct Memo: Equatable, IdentifiableType { // IdentifiableType 프로토콜에는 identity속성이 선언 속성의 형식은 해쉬어블 프로토콜을 채용한 형식으로 제한
    var content: String
    var insertDate: Date
    var identity: String // 메모 구조체에 indentity를 String 선언 String은 해쉬어블을 채용한 형식 프로토콜이 요구하는 사항을 모두 충족
    
    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updateContent: String) {
        self = original
        self.content = updateContent
    }
}

extension Memo: Persistable {
    public static var entityName: String {
        // 엔티티 이름 리턴해야함
        return "Memo"
    }
    
    // 프라이머리 어트리뷰트 속성을 타입 프로퍼티로 선언
    static var primaryAttributeName: String { // 아이디로 사용되는 필드를 리턴해야함
        return "identity"
    }
    
    // NSObjectManagedObject 로 인스턴스를 초기화 하는 생성자 구현
    init(entity: NSManagedObject) {
        content = entity.value(forKey: "content") as! String
        insertDate = entity.value(forKey: "insertDate") as! Date
        identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    // 현재 인스턴스에 저장된 데이터로 NSManagedObject Update하는 메서드 구현
    func update(_ entity: NSManagedObject) {
        entity.setValue(content, forKey: "content")
        entity.setValue(insertDate, forKey: "insertDate")
        entity.setValue("\(insertDate.timeIntervalSinceReferenceDate)", forKey: "identity")
        
        do { // 지금은 RXCoreDate를 사용하지않아 save를 구현
            try entity.managedObjectContext?.save()
        } catch {
            print(error)
        } // RxcoreData는 코어데이터를 context를 자동으로 저장해주기 때문에 save를 직접 호출 할 필요 x
    }
}
