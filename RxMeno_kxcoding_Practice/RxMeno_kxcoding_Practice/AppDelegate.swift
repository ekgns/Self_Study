//
//  AppDelegate.swift
//  RxMeno_kxcoding_Practice
//
//  Created by 다훈김 on 2021/08/09.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 앱이 실행되면 앱델리케이트에사 메모리 저장소와 씬코디네이터가 생성
        // 뷰 모델을 두 인스턴스를 통해서 메모를 저장하고 화면 전환을 처리한다
        // let storage = MemoryStorage() // 메모리 저장소
        let storage = CoreDataStorage(modelName: "RxMeno_kxcoding_Practice")
        let coordinator = SceneCoordinator(window: window!) // 씬 코디네이션
        let listViewModel = MemoListViewModel(title: "나의 메모", sceneCoordinator: coordinator, storage: storage) // 의존성은 뷰 모델을생성할때 생성자를 통해서 주입된다
        let listScene = Scene.list(listViewModel) // 새로운 씬을 생성하고 연관 값으로 뷰 모델을 저장
        coordinator.transition(to: listScene, using: .root, animated: false) //  씬 코디네이터에서 트랜지션 메서드를 호출하고 파라메터로 전달 트랜지션 타입을 루트로 전달
        
        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    // MARK: - Core Data stack

 
}

