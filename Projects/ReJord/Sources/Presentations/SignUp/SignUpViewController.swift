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
  private let waringLabel = WarningLabel(text: ReJordUIStrings.welcomeToVisitRejord, font: .roboto(fontType: .bold, fontSize: 24))
  private let idInputView = SignUpInputView(
    upperLabelText: ReJordUIStrings.id,
    inputType: .withButton
  )
  private let passwordInputView = SignUpInputView(
    upperLabelText: ReJordUIStrings.password,
    inputType: .withSecure
  )
  private let passwordConfirmInputView = SignUpInputView(
    upperLabelText: ReJordUIStrings.confirmPassword,
    inputType: .withSecure
  )
  
  private let signUpButton = ConfirmButton(text: ReJordUIStrings.signUp)
  
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurateUI()
  }
  
  init(reactor: SignUpReactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("SignUpViewcController is deinited")
  }
  
  
  // MARK: - Configuration UI
  
  func configurateUI() {
    self.baseView.snpLayout(baseView: self.view) { make in
      make.edges.equalToSuperview()
    }
    self.logoView.snpLayout(baseView: baseView) { make in
      make.top.equalToSuperview()
      make.height.equalTo(124)
    }
    self.waringLabel.snpLayout(baseView: baseView) { make in
      make.top.equalTo(self.logoView.snp.bottom)
      make.leading.equalToSuperview().inset(29)
    }
    
    self.idInputView.snpLayout(baseView: baseView) { make in
      make.top.equalTo(self.waringLabel.snp.bottom).offset(20)
      make.leading.equalTo(self.waringLabel)
      make.trailing.equalToSuperview().inset(29)
      make.height.equalTo(100)
    }
    self.passwordInputView.snpLayout(baseView: baseView) { make in
      make.top.equalTo(self.idInputView.snp.bottom)
      make.leading.trailing.equalTo(self.idInputView)
      make.height.equalTo(100)
    }
    self.passwordConfirmInputView.snpLayout(baseView: baseView) { make in
      make.top.equalTo(self.passwordInputView.snp.bottom)
      make.leading.trailing.equalTo(self.idInputView)
      make.height.equalTo(100)
    }
    
    self.signUpButton.snpLayout(baseView: baseView) { make in
      make.bottom.equalToSuperview().inset(50)
      make.leading.trailing.equalToSuperview().inset(20)
      make.height.equalTo(47)
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
    
//    self.idInputView.rx.text
      
      
  }

}

