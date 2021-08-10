//
//  ViewModelBindableType.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! {get set}
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}

