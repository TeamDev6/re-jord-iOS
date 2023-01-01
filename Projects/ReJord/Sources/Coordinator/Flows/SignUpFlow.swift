//
//  SignUpFlow.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/10.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import RxFlow
import UIKit

class SignUpFlow: Flow {
  
  
  // MARK: - Private Properties
  
  private var signUpReactor = SignUpReactor(repository: SignUpRepositoryImplement())
  
  
  // MARK: - Life Cycle
  
  init(root: UINavigationController) {
    self.rootViewController = root
  }
  
  // MARK: - Root ViewController
  
  var root: Presentable {
    return self.rootViewController
  }
  
  private var rootViewController: UINavigationController
  
  // MARK: - Navigations
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? ReJordSteps else {
      return .none
    }
    switch step {
    case .signInIsRequired:
      return .none
    case .signUpIsRequired:
      return .none
    case .signUpCompleteSceneIsRequired:
      return self.push(to: step)
    }
  }
  
  private func push(to step: ReJordSteps) -> FlowContributors {
    switch step {
    case .signInIsRequired:
      return .none
    case .signUpIsRequired:
      return .none
    case .signUpCompleteSceneIsRequired:
      let signUpCompleteViewController = SignUpCompleteViewController(reactor: self.signUpReactor)
      self.rootViewController.pushViewController(signUpCompleteViewController, animated: true)
      return .one(flowContributor: .contribute(withNextPresentable: signUpCompleteViewController, withNextStepper: self.signUpReactor))
    
    }
  }
  
  
  
}
