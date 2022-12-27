//
//  SignUpInputView.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import ReactorKit
import SnapKit
import RxCocoa
import Then
import ReJordUI

public enum SignUpInputType {
  case id
  case pwd
  case pwdConfirm
}

class SignUpInputView: UIView, View {
  
  // MARK: - Componenets
  
  private let baseView = UIView().then {
    $0.backgroundColor = .yellow
  }
  public var signUpTextField: SignUpTextFieldView?
  private let upperLabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .medium, fontSize: 16)
    label.sizeToFit()
  }
  private var duplicateInspectionButton: UIButton = {
    let button = UIButton().then { (button: UIButton) in
      button.setButtonProperties(
        cornerRadius: 20,
        backgroundColor: .black,
        text: ReJordUIStrings.checkDuplicate,
        textColor: .white,
        font: .roboto(fontType: .medium, fontSize: 16)
      )
    }
    button.layer.zPosition = 1
    return button
  }()
  private var commentLabel: UILabel = {
    let label = UILabel()
    label.font = .roboto(fontType: .medium, fontSize: 12)
    return label
  }()

  
  
  // MARK: - DisposeBag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  convenience init(reactor: SignUpReactor, upperLabelText text: String, inputType: SignUpInputType) {
    self.init(frame: CGRect.zero)
    self.reactor = reactor
    self.upperLabel.text = text
    switch inputType {
    case .id:
      self.signUpTextField = SignUpTextFieldView()
      self.signUpTextField?.setSignUpPlaceholder(
        newPlaceHolder: ReJordUIStrings.signUpPasswordRestriction,
        placeHolderColor: .gray
      )
    case .pwd, .pwdConfirm:
      self.signUpTextField = SignUpTextFieldView(image: .image(name: "secureGlanceOff"), textSecure: true)
      self.signUpTextField?.setSignUpPlaceholder(
        newPlaceHolder: ReJordUIStrings.signUpIdRestriction,
        placeHolderColor: .gray
      )
    }
    
    self.configurateUI(inputType: inputType)
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Configure UI
  
  func configurateUI(inputType: SignUpInputType) {
    baseView.snpLayout(baseView: self) { make in
      make.edges.equalToSuperview()
      make.height.equalTo(100)
    }
    self.upperLabel.snpLayout(baseView: self.baseView) { make in
      make.top.leading.equalToSuperview()
    }
    switch inputType {
    case .id:
      self.duplicateInspectionButton.snpLayout(baseView: self.baseView) { [weak self] make in
        guard let self else { return }
        make.top.equalTo(self.upperLabel.snp.bottom).offset(11)
        make.height.equalTo(40)
        make.width.equalTo(101)
        make.trailing.equalToSuperview()
      }
      self.signUpTextField?.snpLayout(baseView: self.baseView, snpType: .remake) { [weak self] make in
        guard let self else { return }
        make.centerY.equalTo(self.duplicateInspectionButton)
        make.leading.equalToSuperview()
        make.trailing.equalTo(self.duplicateInspectionButton.snp.leading).offset(-7)
        make.height.equalTo(47)
      }
      
    case .pwd, .pwdConfirm:
      self.signUpTextField?.snpLayout(baseView: self.baseView, snpType: .remake) { [weak self] make in
        guard let self else { return }
        make.top.equalTo(self.upperLabel.snp.bottom).offset(11)
        make.leading.equalToSuperview()
        make.trailing.equalToSuperview()
        make.height.equalTo(47)
      }
    }
  }
  
  // MARK: - bind
  
  func bind(reactor: SignUpReactor) {
    
    self.reactor?.state.map { $0.passwordValue ?? "" }
      .subscribe(onNext: { password in
        guard !password.isEmpty else { return }
        let result = self.verifyPasswordRestriction(verifyText: password)
        if !result {
          self.setTextOnCommentLabel(text: "waring!waring!waring!waring!")
          self.setComment()
        }
      })
      .disposed(by: self.disposeBag)
    
    self.reactor?.state.map { $0.passwordIsEqual }
      .subscribe(onNext: { equalType in
        switch equalType {
        case .empty:
          return
        case .notEqual:
          print("no equal")
        case .equal:
          print("equal")
        }
      })
      .disposed(by: self.disposeBag)
    
  }
  
  
  
  // MARK: - private functions
  
  private func setTextOnCommentLabel(text: String) {
    self.commentLabel.text = text
  }
  
  private func setComment() {
    self.commentLabel.snpLayout(baseView: self.baseView) { [weak self] make in
      guard let self, let signUpTextField = self.signUpTextField else { return }
      make.top.equalTo(signUpTextField.snp.bottom).offset(5)
      make.height.equalTo(30)
      make.leading.equalTo(signUpTextField)
    }
    self.baseView.snpLayout(baseView: self, snpType: .update) { make in
      make.height.equalTo(130)
    }
  }
  
  // 이거 유즈케이스에서 처리해야할거같은데..
  private func verifyPasswordRestriction(verifyText: String) -> Bool {
    guard verifyText.count >= 8 else { return false }
    guard let regex = try? NSRegularExpression(pattern: "^[0-9a-zA-Z]*$") else { return false }
    return regex.firstMatch(in: verifyText, range: NSRange(location: 0, length: verifyText.utf16.count)) != nil
  }
}
