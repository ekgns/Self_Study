//
//  MemoComposeViewController.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class MemoComposeViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MemoComposeViewModel!

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
       
    // 가장 중요한 바인딩
    func bindViewModel() {
        // 먼저 네비게이션 타이틀을 바인딩
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        // 이니셜 텍스트를 텍스트 뷰에 바인딩
        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: rx.disposeBag)
        
                                                        // 메모 쓰기에서는 빈 문자열이 표시되고 편집 모드에서는 편집될 텍스트가 표시
                                                        // 취소 버튼은 캔슬 액션과 바인딩
        cancelButton.rx.action = viewModel.cancelAction // 액션 패턴으로 액션을 구현할때는 액션 속성에 저장하는 방식으로 바인딩 취소 버튼을 탭하면 캔슬액션에 랩핑되어 있는 코드가 실행
                                                        // 세이브 버튼을 바인딩 버튼을 탭하면 텍스트뷰에 입력된 문자를 저장해야함 캔슬 버튼과 조금 다른 방식으로 구현
        
        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance) // 더블 탭을 막기 위해 쓰로틀을 이용해서 0.5초마다 한번씩만 탭을 처리함
            
            .withLatestFrom(contentTextView.rx.text.orEmpty)                 // 위드 레이티스트 프롬 연산자로 텍스트 뷰에 입력된 텍스트를 방출
            
            .bind(to: viewModel.saveAction.inputs)                           //이어서 방출된 텍스트를 세이브 액션과 바인딩
            .disposed(by: rx.disposeBag)
        // MARK: - 키보드
        let willShowObservable = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)          // 노티피케이션 메서드로 처리할 노티피케이션 이름을 전달하면 해당 노티피케이션이 전달 될때 마다 새로운 넥스트이벤트를 방출하는 옵저버블을 리턴한다 그리고 옵저버블이 방출하는 넥스트 이벤트에는 노티피케이션 객체가 저장한다
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0 }
                                                                             // 키보드 높이 필요 맵연산자를 활용해 키보드높이를 방출하는 옵저버블로 변환
                                                                             // 노티피케이션이 전달 되는 시점마다 구독자에게 키보드 높이가 전달
                                                                             // 코코아에서는 세그웨이가 처리하지만
                                                                             // MVVM은 뷰 모델이 처리한다
        let willHideObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).map { noti -> CGFloat in 0 }
        
        let keyboardObservable = Observable.merge(willShowObservable, willHideObservable).share()
        
        keyboardObservable
            .tocontestInset(of: contentTextView)
            .bind(to: contentTextView.rx.contenxtInset)
            .disposed(by: rx.disposeBag)
        
        keyboardObservable
            .toScrollInset(of: contentTextView)
            .bind(to: contentTextView.rx.scrollInset)
            .disposed(by: rx.disposeBag)
    }
    
    // 키보드가 바로 활성화 될 수 있도록 뷰 윌 어피어에 퍼스트 리스펀더로 설정
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentTextView.becomeFirstResponder()
    }
    
    // 이전 씬으로 돌아가기 전에 퍼스트 리스펜더 해제
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
}


extension ObservableType where Element == CGFloat {
    func tocontestInset(of textView: UITextView) -> Observable<UIEdgeInsets> {
        return map { height in
            var inset = textView.contentInset
            inset.bottom = height
            return inset
        }
    }
    
    func toScrollInset(of textView: UITextView) -> Observable<UIEdgeInsets> {
        return map { height in
            var scrollinset = textView.scrollIndicatorInsets
            scrollinset.bottom = height
            return scrollinset
        }
    }
}


extension Reactive where Base: UITextView {
    var contenxtInset: Binder<UIEdgeInsets> {
        return Binder(self.base) { textview, inset in
            textview.contentInset = inset
        }
    }
    var scrollInset: Binder<UIEdgeInsets> {
        return Binder(self.base) { textview, scrollInset in
            textview.scrollIndicatorInsets = scrollInset
        }
    }
}
