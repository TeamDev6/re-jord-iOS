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
    label.font = .roboto(fontType: .medium, fontSize: 12)
    label.sizeToFit()
  }
  
  
  // MARK: - private properties
  
  var viewType: LoginTextFieldInputType?
  
  
  // MARK: - dispose bag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycle
  
  convenience init(reactor: LoginReactor, upperLabelText text: String, inputType: LoginTextFieldInputType) {
    self.init(frame: .zero)
    self.reactor = reactor
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
    self.configurateUI(inputType: inputType)
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - configure UI
  
  private func configurateUI(inputType: LoginTextFieldInputType) {
    baseView.snpLayout(baseView: self) { make in
      make.edges.equalToSuperview()
      make.height.equalTo(100)
    }
    self.upperLabel.snpLayout(baseView: self.baseView) { make in
      make.top.leading.equalToSuperview()
    }
    switch inputType {
    case .id:
      self.signingTextFieldView?.snpLayout(baseView: self.baseView, snpType: .remake) { [weak self] make in
        guard let self else { return }
        make.top.equalTo(self.upperLabel.snp.bottom).inset(11)
        make.trailing.leading.equalToSuperview()
        make.height.equalTo(47)
      }
    case .pwd:
      self.signingTextFieldView?.snpLayout(baseView: self.baseView, snpType: .remake) { [weak self] make in
        guard let self else { return }
        make.top.equalTo(self.upperLabel.snp.bottom).offset(11)
        make.leading.trailing.equalToSuperview()
        make.height.equalTo(47)
      }
    }
  }
  
  
  // MARK: - bind reactor
  
  func bind(reactor: LoginReactor) {
    
  }
  
}
