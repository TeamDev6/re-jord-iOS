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
  private let vStackView = UIStackView().then { (stackView: UIStackView) in
    stackView.backgroundColor = .clear
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
  }
  private let welcomeLabel = UILabel().then { (label: UILabel) in
    label.text = ReJordUIStrings.welcomeToVisitRejord
    label.font = .roboto(fontType: .bold, fontSize: 24)
    label.numberOfLines = 2
    label.sizeToFit()
  }
  private lazy var idInputView: SignUpInputView = { [weak self] in
    guard let self = self else { return SignUpInputView(frame: .zero) }
    guard let reactor = self.reactor else {
      self.reactor?.action.onNext(.errorOccured)
      return SignUpInputView(frame: .zero)
    }
    return SignUpInputView(
     reactor: reactor,
     upperLabelText: ReJordUIStrings.id,
     inputType: .id
   )
  }()
  private lazy var passwordInputView: SignUpInputView = { [weak self] in
    guard let self = self else { return SignUpInputView(frame: .zero) }
    guard let reactor = self.reactor else {
      self.reactor?.action.onNext(.errorOccured)
      return SignUpInputView(frame: .zero)
    }
    return SignUpInputView(
      reactor: reactor,
      upperLabelText: ReJordUIStrings.password,
      inputType: .pwd
    )
  }()
  private lazy var passwordConfirmInputView: SignUpInputView = { [weak self] in
    guard let self = self else { return SignUpInputView(frame: .zero) }
    guard let reactor = self.reactor else {
      self.reactor?.action.onNext(.errorOccured)
      return SignUpInputView(frame: .zero)
    }
    return SignUpInputView(
      reactor: reactor,
      upperLabelText: ReJordUIStrings.confirmPassword,
      inputType: .pwdConfirm
    )
  }()
  
  
  private let signUpButton = ConfirmButton(text: ReJordUIStrings.signUp)
  

  
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
    
    self.setStackArrangesView(subViews: [
      self.idInputView,
      self.passwordInputView,
      self.passwordConfirmInputView,
    ])
    
    self.baseView.snpLayout(baseView: self.view) { make in
      let safeGuide = self.view.safeAreaLayoutGuide
      make.top.bottom.equalTo(safeGuide)
      make.leading.trailing.equalToSuperview().inset(14)
    }
    self.welcomeLabel.snpLayout(baseView: self.baseView) { [weak self] make in
      guard let self else { return }
      make.top.equalTo(self.baseView.snp.top)
      make.leading.equalToSuperview()
    }
    self.vStackView.snpLayout(baseView: self.baseView) { [weak self] make in
      guard let self else { return }
      make.top.equalTo(self.welcomeLabel.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview()
    }
    self.signUpButton.snpLayout(baseView: baseView) { make in
      make.bottom.equalToSuperview().inset(50)
      make.leading.trailing.equalToSuperview().inset(10)
      make.height.equalTo(47)
    }
  }
  
  private func setStackArrangesView(subViews: [UIView]) {
    subViews.forEach { view in
      self.vStackView.addArrangedSubview(view)
    }
  }
  
  
  
  // MARK: - Reactor Binding
  
  func bind(reactor: SignUpReactor) {
    
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
        self?.reactor?.action.onNext(.signUpAction)
      })
      .disposed(by: self.disposeBag)
      
  }

}

