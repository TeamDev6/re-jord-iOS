//
//  SignUpFlow.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/10.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import RxFlow
import UIKit
import ReJordUI
import Moya

class SignUpFlow: Flow {
  
  
  // MARK: - Private Properties
  
  private var signUpViewController: SignUpViewController
  private var signUpReactor: SignUpReactor
  
  
  // MARK: - Life Cycle
  
  init() {
    let signUpReactor = SignUpReactor(repository: SignUpRepositoryImplement(networkProvider: MoyaProvider<ReJordAPI>()))
    self.signUpViewController = SignUpViewController(reactor: signUpReactor)
    self.signUpReactor = signUpReactor
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
    case .signUpIsRequired:
      return self.push(to: step)
    }
  }
  
  private func present(to step: ReJordSteps) -> FlowContributors {
    switch step {
    case .signUpIsRequired:
      return .none
    }
  }
  
  private func push(to step: ReJordSteps) -> FlowContributors {
    switch step {
    case .signUpIsRequired:
      self.rootViewController.pushViewController(self.signUpViewController, animated: false)
      return .one(flowContributor: FlowContributor.contribute(withNextPresentable: self.signUpViewController, withNextStepper: self.signUpReactor))
    }
  }
  
  
  
}
