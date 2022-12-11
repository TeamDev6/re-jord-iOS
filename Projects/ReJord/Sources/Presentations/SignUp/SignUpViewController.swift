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
  private let logoView = UIView()
  private let waringLabel = WarningLabel(text: "RE:욜드에\n오신 것을 환영합니다!")
  private let tempTextField = SignUpTextField(placeholderText: "Placeholder")
  
  
  
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
    self.logoView.setComponent(baseView: baseView) { make in
      make.top.equalToSuperview()
      make.height.equalTo(124)
    }
    self.waringLabel.setComponent(baseView: baseView) { make in
      make.top.equalTo(self.logoView.snp.bottom)
      make.leading.equalToSuperview().inset(29)
    }
    self.tempTextField.setComponent(baseView: baseView) { make in
      make.top.equalTo(self.waringLabel.snp.bottom).offset(20)
      make.leading.equalTo(self.waringLabel)
      make.trailing.equalToSuperview().inset(29)
    }
  }
  

}

