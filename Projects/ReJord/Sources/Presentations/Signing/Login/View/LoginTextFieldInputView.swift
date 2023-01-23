//
//  LoginTextFieldInputView.swift
//  ReJord
//
//  Created by 송하민 on 2023/01/01.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import ReJordUI

public enum LoginTextFieldInputType {
  case id
  case pwd
}

final class LoginTextFieldInputView: UIView, View {
  
  
  // MARK: - components
  
  private let baseView = UIView().then {
    $0.backgroundColor = .clear
  }
  private var signingTextFieldView: SigningTextFieldView?
  private let upperLabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .medium, fontSize: 16)
    label.sizeToFit()
  }
  private var commentLabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .medium, fontSize: 14)
    label.textColor = ReJordUIAsset.warningRed.color
    label.sizeToFit()
  }
  
  // MARK: - component options
  
  private func setTextOnCommentLabel(text: String) {
    self.commentLabel.text = text
    self.commentLabel.sizeToFit()
  
    self.baseView.snp.updateConstraints { make in
      make.height.equalTo(100 + self.commentLabel.intrinsicContentSize.height)
    }
    
  }
  
  private func clearTextOnCommentLabel() {
    self.commentLabel.text = ""
    
    self.baseView.snp.updateConstraints { make in
      make.height.equalTo(100)
    }
  }
  
  
  // MARK: - private properties
  
  var viewType: LoginTextFieldInputType?
  
  
  // MARK: - dispose bag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycle
  
  init() {
    super.init(frame: CGRect.zero)
  }

  init(reactor: LoginReactor, upperLabelText text: String, inputType: LoginTextFieldInputType) {
    super.init(frame: CGRect.zero)
    
    self.upperLabel.text = text
    self.viewType = inputType
    switch inputType {
    case .id:
      self.signingTextFieldView = SigningTextFieldView()
      self.signingTextFieldView?.setSignUpPlaceholder(
        newPlaceHolder: ReJordUIStrings.loginIdPlaceholder,
        placeHolderColor: .gray,
        fontSize: 13
      )
    case .pwd:
      self.signingTextFieldView = SigningTextFieldView(image: ReJordUIAsset.secureGlanceOff.image, textSecure: true)
      self.signingTextFieldView?.setSignUpPlaceholder(
        newPlaceHolder: ReJordUIStrings.loginPwdPlaceholder,
        placeHolderColor: .gray,
        fontSize: 13
      )
    }
    
    Task {
      await self.configurateUI(inputType: inputType)
    }
    
    self.reactor = reactor
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  // MARK: - configure UI
  
  private func configurateUI(inputType: LoginTextFieldInputType) async {
    baseView.snpLayout(baseView: self) { make in
      make.edges.equalToSuperview()
      make.height.equalTo(100)
    }
    self.upperLabel.snpLayout(baseView: self.baseView) { make in
      make.top.leading.equalToSuperview()
      make.height.equalTo(self.upperLabel.intrinsicContentSize.height)
    }
    switch inputType {
    case .id:
      self.signingTextFieldView?.snpLayout(baseView: self.baseView, snpType: .remake) { make in
        make.top.equalTo(self.upperLabel.snp.bottom).offset(11)
        make.trailing.leading.equalToSuperview()
        make.height.equalTo(47)
      }
    case .pwd:
      self.signingTextFieldView?.snpLayout(baseView: self.baseView, snpType: .remake) { make in
        make.top.equalTo(self.upperLabel.snp.bottom).offset(11)
        make.leading.trailing.equalToSuperview()
        make.height.equalTo(47)
      }
      self.commentLabel.snpLayout(baseView: self.baseView) { make in
        guard let signingTextFieldView = self.signingTextFieldView else { return }
        make.top.equalTo(signingTextFieldView.snp.bottom).offset(8)
        make.leading.equalTo(self.upperLabel)
        
      }
    }
  }
  
  
  // MARK: - bind reactor
  
  func bind(reactor: LoginReactor) {
    
    // state
    
    self.reactor?.state
      .skip(1)
      .map { $0.isLoginFail }
      .asDriver(onErrorJustReturn: Pulse<Bool>(wrappedValue: false))
      .drive(onNext: { [weak self] isLoginFail in
        guard self?.viewType == .pwd else { return }
        self?.layoutIfNeeded()
        if isLoginFail.value {
          self?.setTextOnCommentLabel(text: "아이디 또는 비밀번호가 일치하지 않습니다.")
        } else {
          self?.clearTextOnCommentLabel()
        }
      })
      .disposed(by: self.disposeBag)
    
    
    // action
    
    self.signingTextFieldView?.rx.textInput
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] text in
        guard let viewType = self?.viewType else { return }
        switch viewType {
        case .id:
          self?.reactor?.action.onNext(.idInput(id: text))
        case .pwd:
          self?.reactor?.action.onNext(.passwordInput(password: text))
        }
      })
      .disposed(by: self.disposeBag)
    
    
    
  }
  
}
