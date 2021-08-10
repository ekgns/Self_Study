//
//  Memo.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import Foundation

struct Memo: Equatable {
    var content: String
    var insertDate: Date
    var indentity: String
    
    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.indentity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updateContent: String) {
        self = original
        self.content = updateContent
    }
}
