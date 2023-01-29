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
  
  enum PushTransition {
    case pushToSignInViewController
    case pushToSignUpViewController
    case pushToSignUpCompleteViewControllor(signUpResult: SignUpResult)
    case pushToHomeViewController
  }
  
  // MARK: - Private Properties
  
  let loginReactor: LoginReactor = LoginReactor(repository: LoginRepositoryImplement())
  let signUpReactor: SignUpReactor = SignUpReactor(repository: SignUpRepositoryImplement(), signUpResult: nil)
  let homeReactor: HomeReactor = HomeReactor(repository: HomeRepositoryImplemenet())
  
  
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
      return self.push(to: .pushToSignInViewController)
    case .signUpIsRequired:
      return self.push(to: .pushToSignUpViewController)
    case .signUpCompleteSceneIsRequired(let signUpResult):
      return self.push(to: .pushToSignUpCompleteViewControllor(signUpResult: signUpResult))
    case .homeSceneIsRequired:
      return self.push(to: .pushToHomeViewController)
    }
  }
  
  private func push(to step: PushTransition) -> FlowContributors {
    switch step {
    case .pushToSignInViewController:
      let loginViewController = LoginViewController(reactor: self.loginReactor)
      self.rootViewController.pushViewController(loginViewController, animated: true)
      return .one(flowContributor: .contribute(withNextPresentable: loginViewController, withNextStepper: self.loginReactor))
    case .pushToSignUpViewController:
      let signUpFlow = SignUpFlow(root: self.rootViewController)
      let signUpViewController = SignUpViewController(reactor: self.signUpReactor)
      self.rootViewController.pushViewController(signUpViewController, animated: true)
      return .one(flowContributor: .contribute(
        withNextPresentable: signUpFlow,
        withNextStepper: self.signUpReactor
      ))
    case .pushToSignUpCompleteViewControllor(let signUpResult):
      let signUpReactor = SignUpReactor(repository: SignUpRepositoryImplement(), signUpResult: signUpResult)
      let signUpCompleteViewController = SignUpCompleteViewController(reactor: signUpReactor)
      self.rootViewController.pushViewController(signUpCompleteViewController, animated: true)
      return .one(flowContributor: .contribute(withNextPresentable: signUpCompleteViewController, withNextStepper: signUpReactor))
    case .pushToHomeViewController:
      let homeViewController = HomeViewController(reactor: self.homeReactor)
      self.rootViewController.pushViewController(homeViewController, animated: true)
      return .one(flowContributor: .contribute(withNextPresentable: homeViewController, withNextStepper: self.homeReactor))
    }
  }
  
  
  
}
