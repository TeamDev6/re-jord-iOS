//
//  LoginViewController.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/30.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import ReJordUI

final class LoginViewController: UIViewController, Layoutable, View {
  
  
  
  // MARK: - components
  
  // test
  private let moveTestButton = UIButton().then { $0.backgroundColor = .blue }
  
  private var baseView = UIView().then {
    $0.backgroundColor = .clear
  }
  private let loginTitleLabel = UILabel().then { (label: UILabel) in
    label.text = ReJordUIStrings.loginTitle
    label.font = .roboto(fontType: .bold, fontSize: 24)
    label.textColor = .black
    label.sizeToFit()
  }
  private let loginSubTitleLabel = UILabel().then { (label: UILabel) in
    label.text = ReJordUIStrings.loginSubTitle
    label.numberOfLines = 2
    label.font = .roboto(fontType: .medium, fontSize: 16)
    label.textColor = .gray
    label.sizeToFit()
  }
  private lazy var loginComponentStack: UIStackView = { [weak self] in
    let stackView = UIStackView()
    guard let self else { return stackView }
    stackView.backgroundColor = .clear
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.setStackArrangesView(subViews: [
      self.idInputView,
      self.passwordInputView
    ])
    return stackView
  }()
  private lazy var idInputView: LoginTextFieldInputView = { [weak self] in
    guard let self,
          let reactor = self.reactor else {
      self?.reactor?.action.onNext(.errorOccured)
      return LoginTextFieldInputView(frame: .zero)
    }
    return LoginTextFieldInputView(reactor: reactor, upperLabelText: ReJordUIStrings.id, inputType: .id)
  }()
  private lazy var passwordInputView: LoginTextFieldInputView = { [weak self] in
    guard let self,
          let reactor = self.reactor else {
      self?.reactor?.action.onNext(.errorOccured)
      return LoginTextFieldInputView(frame: .zero)
    }
    return LoginTextFieldInputView(
      reactor: reactor,
      upperLabelText: ReJordUIStrings.password,
      inputType: .pwd
    )
  }()
  private let loginButton = ConfirmButton(text: ReJordUIStrings.doLogin)
  private lazy var gotoSignUpGestureLabel: UILabel = { [weak self] in
    var label = UILabel()
    guard let self else { return label }
    label.text = ReJordUIStrings.gotoSignUp
    label.textColor = .gray
    label.sizeToFit()
    let tapGesture = UITapGestureRecognizer()
    tapGesture.addTarget(self, action: #selector(gotoSignUpAction))
    label.addGestureRecognizer(tapGesture)
    return label
  }()
  
  // MARK: - component options
  
  
  // MARK: - private properties
  
  
  // MARK: - private functions
  
  @objc private func gotoSignUpAction() {
    
  }
  
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycles
  
  init(reactor: LoginReactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.setLayout()
    
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - layout
  
  func setLayout() {
    
    self.baseView.snpLayout(baseView: self.view) { make in
      let safeGuide = self.view.safeAreaLayoutGuide
      make.top.bottom.equalTo(safeGuide)
      make.leading.trailing.equalToSuperview().inset(14)
    }
    self.loginTitleLabel.snpLayout(baseView: self.baseView) { make in
      make.top.leading.equalToSuperview()
    }
    self.loginSubTitleLabel.snpLayout(baseView: self.baseView) { make in
      make.top.equalTo(self.loginTitleLabel.snp.bottom)
      make.leading.equalToSuperview()
    }
    self.loginComponentStack.snpLayout(baseView: self.baseView) { [weak self] make in
      guard let self else { return }
      make.top.equalTo(self.loginSubTitleLabel.snp.bottom).offset(15)
      make.leading.trailing.equalToSuperview()
    }
    self.loginButton.snpLayout(baseView: self.baseView) { [weak self] make in
      guard let self else { return }
      make.top.equalTo(self.loginComponentStack.snp.bottom).inset(25)
      make.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }
    self.gotoSignUpGestureLabel.snpLayout(baseView: self.baseView) { [weak self] make in
      guard let self else { return }
      make.top.equalTo(self.loginButton.snp.bottom).inset(31)
      make.centerX.equalToSuperview()
    }
    
  }
  
  
  // MARK: - bind reactor
  
  func bind(reactor: LoginReactor) {
    
    
    
    
    
    // test
    self.moveTestButton.rx.tap
      .subscribe(onNext: { _ in
        self.reactor?.action.onNext(.gotoSignUpScene)
      })
      .disposed(by: self.disposeBag)
  }
  
  
  
  
}