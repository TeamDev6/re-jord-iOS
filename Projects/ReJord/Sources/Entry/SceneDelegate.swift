//
//  SceneDelegate.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/10.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import RxFlow
import RxSwift
import UIKit
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  let disposeBag = DisposeBag()
  var window: UIWindow?
  var coordinator = FlowCoordinator()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    FirebaseApp.configure()
    
    coordinator.rx.willNavigate
      .subscribe { flow, step in
        print("will navigate flow ~> \(flow), with step ~> \(step)")
      }.disposed(by: self.disposeBag)
    
    window = UIWindow(windowScene: windowScene)
    
    let signUpFlow = SignUpFlow()
    
    self.coordinator.coordinate(
      flow: signUpFlow,
      with: AppStepper()
    )
    
    Flows.use(signUpFlow, when: .created) { root in
      self.window?.rootViewController = root
      self.window?.makeKeyAndVisible()
    }
  }
  
  func sceneDidDisconnect(_ scene: UIScene) { }
  func sceneDidBecomeActive(_ scene: UIScene) { }
  func sceneWillResignActive(_ scene: UIScene) { }
  func sceneWillEnterForeground(_ scene: UIScene) { }
  func sceneDidEnterBackground(_ scene: UIScene) { }
  
  
}
