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

  
  // MARK: - componenets
  
  private let baseView = UIView().then {
    $0.backgroundColor = .white
  }
  private lazy var signUpComponentStack: UIStackView = { [weak self] in
    let stackView = UIStackView()
    guard let self else { return stackView }
    stackView.backgroundColor = .clear
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.setStackArrangesView(subViews: [
      self.idInputView,
      self.passwordInputView,
      self.passwordConfirmInputView,
    ])
    return stackView
  }()
  private let welcomeLabel = UILabel().then { (label: UILabel) in
    label.text = ReJordUIStrings.welcomeToVisitRejord
    label.font = .roboto(fontType: .bold, fontSize: 24)
    label.numberOfLines = 2
    label.sizeToFit()
  }
  private lazy var idInputView: SignUpTextFieldInputView = { [weak self] in
    guard let self,
          let reactor = self.reactor else {
      self?.reactor?.action.onNext(.errorOccured)
      return SignUpTextFieldInputView(frame: .zero)
    }
    return SignUpTextFieldInputView(
     reactor: reactor,
     upperLabelText: ReJordUIStrings.id,
     inputType: .id
   )
  }()
  private lazy var passwordInputView: SignUpTextFieldInputView = { [weak self] in
    guard let self,
          let reactor = self.reactor else {
      self?.reactor?.action.onNext(.errorOccured)
      return SignUpTextFieldInputView(frame: .zero)
    }
    return SignUpTextFieldInputView(
      reactor: reactor,
      upperLabelText: ReJordUIStrings.password,
      inputType: .pwd
    )
  }()
  private lazy var passwordConfirmInputView: SignUpTextFieldInputView = { [weak self] in
    guard let self,
          let reactor = self.reactor else {
      self?.reactor?.action.onNext(.errorOccured)
      return SignUpTextFieldInputView(frame: .zero)
    }
    return SignUpTextFieldInputView(
      reactor: reactor,
      upperLabelText: ReJordUIStrings.confirmPassword,
      inputType: .pwdConfirm
    )
  }()
  private let signUpButton = ConfirmButton(text: ReJordUIStrings.signUp)
    
  
  // MARK: - dispose bag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
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
      let safeGuide = self.view.safeAreaLayoutGuide
      make.top.equalTo(safeGuide).offset(45)
      make.bottom.equalTo(safeGuide)
      make.leading.trailing.equalToSuperview().inset(14)
    }
    self.welcomeLabel.snpLayout(baseView: self.baseView) { make in
      make.top.equalTo(self.baseView.snp.top)
      make.leading.equalToSuperview()
    }
    self.signUpComponentStack.snpLayout(baseView: self.baseView) { make in
      make.top.equalTo(self.welcomeLabel.snp.bottom).offset(29)
      make.leading.trailing.equalToSuperview()
    }
    self.signUpButton.snpLayout(baseView: baseView) { make in
      make.bottom.equalToSuperview().inset(50)
      make.leading.trailing.equalToSuperview().inset(10)
      make.height.equalTo(47)
    }
  }
  
  
  // MARK: - reactor rinding
  
  func bind(reactor: SignUpReactor) {
    
    self.idInputView.signingTextFieldView?.baseTextField.rx.text
      .asDriver()
      .drive(onNext: { [weak self] idText in
        self?.reactor?.action.onNext(.idValueInserted(value: idText))
      })
      .disposed(by: self.disposeBag)
    
    self.passwordInputView.signingTextFieldView?.baseTextField.rx.text
      .asDriver()
      .drive(onNext: { [weak self] passwordText in
        self?.reactor?.action.onNext(.passwordValueInserted(value: passwordText))
      })
      .disposed(by: self.disposeBag)
    
    self.passwordConfirmInputView.signingTextFieldView?.baseTextField.rx.text
      .asDriver()
      .drive(onNext: { [weak self] passwordConfirmText in
        self?.reactor?.action.onNext(.passwordConfirmValueInserted(value: passwordConfirmText))
      })
      .disposed(by: self.disposeBag)
    
    self.signUpButton.rx.tap
      .asDriver()
      .drive(onNext: { [weak self] _ in
        self?.reactor?.action.onNext(.signUpAction)
      })
      .disposed(by: self.disposeBag)
      
  }

}

