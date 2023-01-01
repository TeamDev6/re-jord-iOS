//
//  SignInFlow.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/31.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import RxFlow
import UIKit

class LoginFlow: Flow {
  
  
  // MARK: - Private Properties
  
  let loginReactor: LoginReactor = LoginReactor(repository: SignUpRepositoryImplement())
  let signUpReactor: SignUpReactor = SignUpReactor(repository: SignUpRepositoryImplement())
  
  
  // MARK: - Life Cycle
  
  init() {
    
  }
  
  // MARK: - Root ViewController
  
  var root: Presentable {
    return self.rootViewController
  }
  
  private lazy var rootViewController: UINavigationController = {
    let viewController = UINavigationController()
    return viewController
  }()
  
  // MARK: - Navigations
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? ReJordSteps else {
      return .none
    }
    switch step {
    case .signInIsRequired:
      return self.push(to: step)
    case .signUpIsRequired:
      return self.push(to: step)
    case .signUpCompleteSceneIsRequired:
      return .none
    }
  }
  
  private func push(to step: ReJordSteps) -> FlowContributors {
    switch step {
    case .signInIsRequired:
      let loginViewController = LoginViewController(reactor: self.loginReactor)
      self.rootViewController.pushViewController(loginViewController, animated: true)
      return .one(flowContributor: .contribute(withNextPresentable: loginViewController, withNextStepper: self.loginReactor))
    case .signUpIsRequired:
      let signUpFlow = SignUpFlow(root: self.rootViewController)
      let signUpViewController = SignUpViewController(reactor: self.signUpReactor)
      self.rootViewController.pushViewController(signUpViewController, animated: true)
      return .one(flowContributor: .contribute(
        withNextPresentable: signUpFlow,
        withNextStepper: self.signUpReactor
      ))
    case .signUpCompleteSceneIsRequired:
      return .none
    }
  }
  
  
  
}
