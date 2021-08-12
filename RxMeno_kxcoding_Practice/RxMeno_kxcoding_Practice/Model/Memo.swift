//
//  Memo.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation
import RxDataSources // 테이블 뷰와 콜렉션뷰에 바인딩 될 수 있는 DataSource를 제공한다
// DataSource에 저장되는 모든 데이터는 반드시 IdentifiableType 프로토콜을 채용해야한다



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
