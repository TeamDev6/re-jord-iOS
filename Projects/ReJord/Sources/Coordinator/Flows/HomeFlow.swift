//
//  HomeFlow.swift
//  ReJord
//
//  Created by 송하민 on 2023/02/04.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import Foundation
import RxFlow
import UIKit

class HomeFlow: Flow {
  
  enum PushTransition {
    case showHome
  }
  
  enum PresentTransition {
    
  }
  
  // MARK: - Private Properties

  private var homeReactor: HomeReactor?
  
  
  // MARK: - Life Cycle
  
  init(reactor: HomeReactor) {
    self.homeReactor = reactor
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
    case .homeTabIsRequired:
      return push(to: .showHome)
    default:
      return .none
    }
    
  }
  
  private func push(to step: PushTransition) -> FlowContributors {
    switch step {
    case .showHome:
      guard let homeReactor else { return .none }
      let homeVC = HomeViewController(reactor: homeReactor)
      self.rootViewController.pushViewController(homeVC, animated: false)
      return .one(flowContributor: .contribute(withNextPresentable: homeVC, withNextStepper: homeReactor))
    }
  }
  
  private func present(to step: PresentTransition) -> FlowContributors {
    switch step {
      
    }
  }

}
