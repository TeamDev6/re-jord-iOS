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

class SignUpViewController: UIViewController, Layoutable, View {
  
  
  // MARK: - Private Properties
  
  var disposeBag: DisposeBag = DisposeBag()
  
  
  // MARK: - Componenets
  
  private let baseView = UIView().then {
    $0.backgroundColor = .white
  }
  private let logoView = UIView()
  private let waringLabel = WarningLabel(
    text: ReJordUIStrings.welcomeToVisitRejord,
    font: .roboto(fontType: .bold, fontSize: 24)
  )
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
  
  
  // MARK: - Private Properites
  
  private var currentId: String?
  private var currentPwd: String?
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setLayout()
  }
  
  init(reactor: SignUpReactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("\(self) is deinited")
  }
  
  
  // MARK: - Configuration UI
  
  func setLayout() {
    self.baseView.snpLayout(baseView: self.view) { make in
      make.edges.equalToSuperview()
      make.width.height.equalToSuperview()
    }
    self.logoView.snpLayout(baseView: baseView) { make in
      make.width.leading.trailing.top.equalToSuperview()
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
    
    self.reactor?.state
      .map { $0.idValue }
      .subscribe(onNext: { [weak self] id in
        self?.currentId = id
      })
      .disposed(by: self.disposeBag)
    
    self.reactor?.state
      .map { $0.passwordValue }
      .subscribe(onNext: { [weak self] pwd in
        self?.currentPwd = pwd
      })
      .disposed(by: self.disposeBag)
 
    self.idInputView.signUpTextField?.baseTextField.rx.text
      .asDriver()
      .drive(onNext: { [weak self] idText in
        self?.reactor?.action.onNext(.idValueInserted(value: idText))
      })
      .disposed(by: self.disposeBag)
    
    self.passwordInputView.signUpTextField?.baseTextField.rx.text
      .asDriver()
      .drive(onNext: { [weak self] passwordText in
        self?.reactor?.action.onNext(.passwordValueInserted(value: passwordText))
      })
      .disposed(by: self.disposeBag)
    
    self.passwordConfirmInputView.signUpTextField?.baseTextField.rx.text
      .asDriver()
      .drive(onNext: { [weak self] passwordConfirmText in
        self?.reactor?.action.onNext(.passwordConfirmValueInserted(value: passwordConfirmText))
      })
      .disposed(by: self.disposeBag)
    
    self.signUpButton.rx.tap
      .asDriver()
      .drive(onNext: { [weak self] _ in
        guard let id = self?.currentId,
              let pwd = self?.currentPwd else { return }
        self?.reactor?.action.onNext(.signUpAction(id: id, pwd: pwd))
      })
      .disposed(by: self.disposeBag)
      
  }

}

