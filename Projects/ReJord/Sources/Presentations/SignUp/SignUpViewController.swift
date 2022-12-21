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
  private let vStackView = UIStackView().then { (stackView: UIStackView) in
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
  }
  private let welcomeLabel = UILabel().then { (label: UILabel) in
    label.text = ReJordUIStrings.welcomeToVisitRejord
    label.font = .roboto(fontType: .bold, fontSize: 24)
    label.numberOfLines = 2
  }
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
    print("SignUpViewcController is deinited")
  }
  
  // MARK: - Private Function
  
  private func makeWarningLabel(warningText: String) -> WarningLabel {
    return WarningLabel(text: warningText, font: .roboto(fontType: .medium, fontSize: 12), color: .red)
  }
  
  // MARK: - Configuration UI
  
  func setLayout() {
    
    self.setStackArrangesView(subViews: [
      self.welcomeLabel,
      self.idInputView,
      self.passwordInputView,
      self.passwordConfirmInputView,
    ])
    
    self.baseView.snpLayout(baseView: self.view) { make in
      make.edges.equalToSuperview()
      make.width.height.equalToSuperview()
    }
    self.logoView.snpLayout(baseView: baseView) { make in
      self.logoView.backgroundColor = .gray
      make.width.leading.trailing.top.equalToSuperview()
      make.height.equalTo(124)
    }
    
    self.signUpButton.snpLayout(baseView: baseView) { make in
      make.bottom.equalToSuperview().inset(50)
      make.leading.trailing.equalToSuperview().inset(20)
      make.height.equalTo(47)
    }
    
    self.vStackView.snpLayout(baseView: self.view) { make in
      self.vStackView.backgroundColor = .blue
      make.top.equalTo(self.logoView.snp.bottom)
      make.leading.trailing.equalToSuperview().inset(12)
      
      self.welcomeLabel.snp.makeConstraints { make in
        make.top.equalTo(self.logoView.snp.bottom)
        make.leading.equalToSuperview()
      }
      self.idInputView.snp.makeConstraints { make in
        make.height.equalTo(100)
      }
      self.passwordInputView.snp.makeConstraints { make in
        make.height.equalTo(100)
      }
      self.passwordConfirmInputView.snp.makeConstraints { make in
        make.height.equalTo(100)
      }
    }
  }
  
  private func setStackArrangesView(subViews: [UIView]) {
    subViews.forEach { view in
      self.vStackView.addArrangedSubview(view)
    }
    guard let warningView = subViews.first else { return }
    self.vStackView.setCustomSpacing(80, after: warningView )
  }
  
  
  // MARK: - Reactor Binding
  
  func bind(reactor: SignUpReactor) {
    
    self.reactor?.state.map { $0.passwordIsEqual }
      .subscribe(onNext: { equal in
        print("is equal ? `> \(equal)")
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
        self?.reactor?.action.onNext(.signUpAction)
      })
      .disposed(by: self.disposeBag)
      
  }

}

