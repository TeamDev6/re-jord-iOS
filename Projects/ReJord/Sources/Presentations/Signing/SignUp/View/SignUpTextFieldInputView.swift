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

public enum SignUpTextFieldInputType {
  case id
  case pwd
  case pwdConfirm
}

class SignUpTextFieldInputView: UIView, View {
  
  // MARK: - Componenets
  
  private let baseView = UIView().then {
    $0.backgroundColor = .clear
  }
  public var signUpTextField: SigningTextFieldView?
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

  
  // MARK: - private properties
  
  var viewType: SignUpTextFieldInputType?
  
  
  // MARK: - DisposeBag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  convenience init(reactor: SignUpReactor, upperLabelText text: String, inputType: SignUpTextFieldInputType) {
    self.init(frame: CGRect.zero)
    self.reactor = reactor
    self.upperLabel.text = text
    self.viewType = inputType
    switch inputType {
    case .id:
      self.signUpTextField = SigningTextFieldView()
      self.signUpTextField?.setSignUpPlaceholder(
        newPlaceHolder: ReJordUIStrings.signUpIdRestriction,
        placeHolderColor: .gray,
        fontSize: 13
      )
    case .pwd, .pwdConfirm:
      self.signUpTextField = SigningTextFieldView(image: ReJordUIAsset.secureGlanceOff.image, textSecure: true)
      self.signUpTextField?.setSignUpPlaceholder(
        newPlaceHolder: ReJordUIStrings.signUpPasswordRestriction,
        placeHolderColor: .gray,
        fontSize: 13
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
  
  func configurateUI(inputType: SignUpTextFieldInputType) {
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
    
    // state
    
    self.reactor?.state.map { $0.passwordValue ?? "" }
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] password in
        guard let self, let viewType = self.viewType else { return }
        guard !password.isEmpty else {
          Task {
            await self.removeComment()
          }
          return
        }
        let isAband = !self.verifyPasswordRestriction(verifyText: password)
        if viewType == .pwd {
          let commentTitle = isAband ? ReJordUIStrings.signUpPasswordRestriction : ReJordUIStrings.signUpAvailablePassword
          Task {
            await self.setTextOnCommentLabel(text: commentTitle, isWarning: isAband)
          }
        }
      })
      .disposed(by: self.disposeBag)
    
    self.reactor?.state.map { $0.passwordIsEqual }
      .asDriver(onErrorJustReturn: .empty)
      .drive(onNext: { [weak self] equalType in
        guard let viewType = self?.viewType, viewType == .pwdConfirm else { return }
        Task {
          switch equalType {
          case .empty:
            await self?.removeComment()
          case .notEqual:
            await self?.setTextOnCommentLabel(text: ReJordUIStrings.signUpPasswordMismatch, isWarning: true)
          case .equal:
            await self?.setTextOnCommentLabel(text: ReJordUIStrings.signUpPasswordMatch, isWarning: false)
          }
        }
      })
      .disposed(by: self.disposeBag)
    
    self.reactor?.state.map { $0.idIsAvailable }
      .asDriver(onErrorJustReturn: .checkYet)
      .drive(onNext: { [weak self] checkType in
        Task {
          guard let viewType = self?.viewType, viewType == .id else { return }
          switch checkType {
          case .checkYet:
            await self?.removeComment()
          case .available:
            await self?.setTextOnCommentLabel(text: ReJordUIStrings.signUpAvailableId, isWarning: false)
          case .duplicated:
            await self?.setTextOnCommentLabel(text: ReJordUIStrings.signUpIdDuplicate, isWarning: true)
          }
        }
      })
      .disposed(by: self.disposeBag)
    
    
    // action
    
    self.duplicateInspectionButton.rx.tap
      .asDriver()
      .drive(onNext: { [weak self] _ in
        self?.reactor?.action.onNext(.checkIdDuplication)
      })
      .disposed(by: self.disposeBag)
    
  }
  
  
  
  // MARK: - private functions
  
  private func setTextOnCommentLabel(text: String, isWarning: Bool) async {
    self.commentLabel.text = text
    self.commentLabel.textColor = isWarning ? .red : .green
    await self.setComment()
  }
  
  private func setComment() async {
    self.commentLabel.snpLayout(baseView: self.baseView) { [weak self] make in
      guard let self, let signUpTextField = self.signUpTextField else { return }
      make.top.equalTo(signUpTextField.snp.bottom).offset(5)
      make.leading.equalTo(signUpTextField)
    }
    self.baseView.snpLayout(baseView: self, snpType: .update) { make in
      make.height.equalTo(125)
    }
  }
  
  private func removeComment() async {
    self.commentLabel.removeFromSuperview()
    self.baseView.snpLayout(baseView: self, snpType: .update) { make in
      make.height.equalTo(100)
    }
  }
  
  // 이거 유즈케이스에서 처리해야할거같은데..
  private func verifyPasswordRestriction(verifyText: String) -> Bool {
    guard verifyText.count >= 8 else { return false }
    guard let regex = try? NSRegularExpression(pattern: "^[0-9a-zA-Z]*$") else { return false }
    return regex.firstMatch(in: verifyText, range: NSRange(location: 0, length: verifyText.utf16.count)) != nil
  }
}
