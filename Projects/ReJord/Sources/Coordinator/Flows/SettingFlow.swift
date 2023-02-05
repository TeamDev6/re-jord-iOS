//
//  SettingFlow.swift
//  ReJord
//
//  Created by 송하민 on 2023/02/04.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import Foundation
import RxFlow
import UIKit

class SettingsFlows: Flow {
  
  enum PushTransition {
    case showSettings
  }
  
  enum PresentTransition {
    
  }
  
  // MARK: - Private Properties
  
  private var settingsReactor: SettingsReactor?
  
  // MARK: - Life Cycle
  
  init(reactor: SettingsReactor) {
    self.settingsReactor = reactor
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
    case .settingsTabIsRequired:
      return push(to: .showSettings)
    default:
      return .none
    }
    
  }
  
  private func push(to step: PushTransition) -> FlowContributors {
    switch step {
    case .showSettings:
      guard let settingsReactor else { return .none }
      let settingsVC = SettingsViewController(reactor: settingsReactor)
      self.rootViewController.pushViewController(settingsVC, animated: false)
      return .one(flowContributor: .contribute(withNextPresentable: settingsVC, withNextStepper: settingsReactor))
    }
  }
  
  private func present(to step: PresentTransition) -> FlowContributors {
    switch step {
      
    }
  }
  
}
