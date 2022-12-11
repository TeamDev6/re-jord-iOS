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

final class SignUpViewController: UIViewController {
  
  // MARK: - Componenets
  
  private let baseView = UIView().then {
    $0.backgroundColor = .white
  }
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurateUI()
  }
  
  deinit {
    print("SignUpViewcController is deinited")
  }
  
  // MARK: - Configuration UI
  
  private func configurateUI() {
    self.baseView.setComponent(baseView: self.view) { make in
      make.edges.equalToSuperview()
    }
  }
  

}

