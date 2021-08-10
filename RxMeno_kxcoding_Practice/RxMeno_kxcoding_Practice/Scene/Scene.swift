//
//  Scene.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import UIKit

enum Scene { // 앱에서 구현할 씬을 열거형으로 선언
    // 씬과 연관된 뷰모델을 연관값으로 저장
    case list(MemoListViewModel) // 메모리스트 화면
    case detail(MemoDetailViewModel) // 메모 디테일 화면
    case compose(MemoComposeViewModel) // 새 메모 화면
}

extension Scene { // 스토리보드에 있는 씬을 생성하고 (위에 있는)연관 값에 저장된 뷰 모델을 바인딩해서 리턴하는 메서드 구현
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        // 메모 목록 씬을 생성한 다음에 뷰 모델을 바인딩해서 리턴
        // 네비게이션 컨트롤러의 indentifier를 다시 말해서 스토리보드 아이딜르 리스트 네비게이션이라고 설정해줬었다 그걸 가져온다
        switch self {
        case .list(let viewModel): // 리스트 씬이 실제로 생성 되는 곳
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else { // 스토리보드에서 씬을 생성하고
                fatalError()
            }
            
            guard var listVC = nav.viewControllers.first as? MemoListViewController
            else {
                fatalError()
            }
//            연관값에 저장된 뷰 모델을 바인딩 하고있다
            listVC.bind(viewModel: viewModel)   // 뷰 모델은 네비게이션 컨트롤러에 임베디드되있는 루트뷰 컨트롤러에 바인딩하고 리턴할떈 네비케이션 컨트롤러를 리턴해야한다
            return nav
          
        // 상세보기 씬 생성
        case .detail(let viewModel): // 이 씬은 항상 네비게이션에 스택에 푸쉬 되기 때문에 네비게이션 컨트롤러를 고려 할 필요 없다
        guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {
            fatalError()
        }
            detailVC.bind(viewModel: viewModel)
            return detailVC
            
        // 새 메모 씬 생성
        case .compose(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                fatalError()
            }
            
            composeVC.bind(viewModel: viewModel)
            return nav
        }
    }
}
