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
  
  enum PushTransition {
    case pushToSignUpCompletViewController(signUpResult: SignUpResult)
  }
  
  
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
    case .signUpCompleteSceneIsRequired(let signUpResult):
      return self.push(to: .pushToSignUpCompletViewController(signUpResult: signUpResult))
    case .homeSceneIsRequired:
      return .one(flowContributor: .forwardToParentFlow(withStep: ReJordSteps.homeSceneIsRequired))
    }
  }
  
  private func push(to step: PushTransition) -> FlowContributors {
    switch step {
    case .pushToSignUpCompletViewController(let signUpResult):
      let signUpCompleteViewController = SignUpCompleteViewController(reactor: self.signUpReactor, signUpResult: signUpResult)
      self.rootViewController.pushViewController(signUpCompleteViewController, animated: true)
      return .one(flowContributor: .contribute(withNextPresentable: signUpCompleteViewController, withNextStepper: self.signUpReactor))
    
    }
  }
  
  
  
}
