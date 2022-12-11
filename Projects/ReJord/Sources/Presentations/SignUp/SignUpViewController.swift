//
//  SignUpViewController.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReJordUI
import RxFlow
import Then
import ReactorKit

final class SignUpViewController: UIViewController, Layoutable, View {
  
  
  // MARK: - Private Properties
  
  var disposeBag: DisposeBag = DisposeBag()
  
  
  // MARK: - Componenets
  
  private let baseView = UIView().then {
    $0.backgroundColor = .white
  }
  private let logoView = UIView()
  private let waringLabel = WarningLabel(text: "RE:욜드에\n오신 것을 환영합니다!")

  private let idInputView = SignUpInputView(upperLabelText: "Label", inputType: .withButton)
  private let passwordInputView = SignUpInputView(upperLabelText: "Password", inputType: .withSecure)
  private let passwordConfirmInputView = SignUpInputView(upperLabelText: "Password", inputType: .withSecure)
  private let signUpButton = UIButton().then {
    $0.backgroundColor = .gray
  }
  
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurateUI()
    self.reactor = SignUpReactor(repository: SignUpRepositoryImplement())
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
    self.idInputView.setComponent(baseView: baseView) { make in
      make.top.equalTo(self.waringLabel.snp.bottom).offset(20)
      make.leading.equalTo(self.waringLabel)
      make.trailing.equalToSuperview().inset(29)
      make.height.equalTo(100)
    }
    self.passwordInputView.setComponent(baseView: baseView) { make in
      make.top.equalTo(self.idInputView.snp.bottom)
      make.leading.trailing.equalTo(self.idInputView)
      make.height.equalTo(100)
    }
    self.passwordConfirmInputView.setComponent(baseView: baseView) { make in
      make.top.equalTo(self.passwordInputView.snp.bottom)
      make.leading.trailing.equalTo(self.idInputView)
      make.height.equalTo(100)
    }
    self.signUpButton.setComponent(baseView: baseView) { make in
      make.bottom.equalToSuperview().inset(50)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(60)
    }
  }
  
  
  // MARK: - Reactor Binding
  
  func bind(reactor: SignUpReactor) {
    
    self.signUpButton.rx.tap
      .asDriver()
      .drive(onNext: { [weak self] _ in
        self?.reactor?.action.onNext(.signUpAction)
      })
      .disposed(by: self.disposeBag)
      
      
  }

}

