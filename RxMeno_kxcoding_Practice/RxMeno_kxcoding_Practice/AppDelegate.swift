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
        let storage = MemoryStorage() // 메모리 저장소
        let coordinator = SceneCoordinator(window: window!) // 씬 코디네이션
        let listViewModel = MemoListViewModel(title: "나의 메모", sceneCoordinator: coordinator, storage: storage) // 이들에 대한 의존성은 뷰 모델을생성할때 생성자를 통해서 주입된다 그다음 새로운 씬을 생성하고 연관 값으로 뷰 모델을 저장 이어서 씬 코디네이터에서 트랜지션 메서드를 호출하고 파라메터로 전달 트랜지션 타입을 루트로 전달
        let listScene = Scene.list(listViewModel)
        coordinator.transition(to: listScene, using: .root, animated: false)
        
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

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "RxMeno_kxcoding_Practice")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

