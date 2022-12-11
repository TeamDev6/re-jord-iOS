//
//  SignUpViewController.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import SnapKit
import ReJordUI
import RxFlow
import Then

final class SignUpViewController: UIViewController, Layoutable {
  
  // MARK: - Componenets
  
  private let baseView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let waringLabel = WarningLabel(text: "this is rejord modulated label test")
  
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurateUI()
  }
  
  deinit {
    print("SignUpViewcController is deinited")
  }
  
  // MARK: - Configuration UI
  
  func configurateUI() {
    self.baseView.setComponent(baseView: self.view) { make in
      make.edges.equalToSuperview()
    }
    self.waringLabel.setComponent(baseView: baseView) { make in
      make.centerX.centerY.equalToSuperview()
    }
  }
  

}

