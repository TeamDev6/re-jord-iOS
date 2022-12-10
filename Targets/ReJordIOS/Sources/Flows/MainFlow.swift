//
//  MainFlow.swift
//  ReJordIOS
//
//  Created by 송하민 on 2022/12/08.
//  Copyright © 2022 reJordiOS. All rights reserved.
//

import RxSwift
import RxCocoa
import RxFlow
import UIKit

class MainFlow: Flow {
  
  var root: Presentable {
    return self.rootViewController
  }
  
  private lazy var rootViewController: UINavigationController = {
    let viewController = UINavigationController()
    return viewController
  }()
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? FlowSteps else { return .none }
    
    switch step {
    case .mainSearchIsRequired:
      return transitionToMain()
    default:
      return .none
    }
  }
  
  private func transitionToMain() -> FlowContributors {
    var mainViewController = MainViewController()
    self.rootViewController.setViewControllers([mainViewController], animated: true)
    return .none
  }
  
}

class MainStepper: Stepper {
  
  let steps = PublishRelay<Step>()
  private let disposeBag = DisposeBag()
  
  var initialStep: Step {
    return FlowSteps.mainSearchIsRequired
  }
  
}
