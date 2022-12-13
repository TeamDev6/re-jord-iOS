//
//  SignUpInputView.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import SnapKit
import Then

public enum SignUpInputType {
  case withButton
  case withSecure
}

open class SignUpInputView: UIView {
  
  // MARK: - Componenets
  
  private let baseView = UIView().then {
    $0.backgroundColor = .white
  }
  private let signUpTextField = SignUpTextField(placeholderText: "placeholder")
  private let upperLabel = UILabel().then { (label: UILabel) in
    label.font = UIFont(font: ReJordUIFontFamily.Roboto.medium, size: 16)
    label.sizeToFit()
  }
  private var duplicateInspectionButton: UIButton = {
    let button = UIButton().then { (button: UIButton) in
      button.setButtonProperties(cornerRadius: 20, backgroundColor: .black, text: "중복체크", textColor: .white, font: UIFont(font: ReJordUIFontFamily.Roboto.medium, size: 16)!)
    }
    return button
  }()
  
  
  // MARK: - Life Cycle
  
  convenience public init(upperLabelText text: String, inputType: SignUpInputType) {
    self.init(frame: CGRect.zero)
    self.setTextUpperLabel(upperText: text)
    if inputType == .withSecure {
      self.setImageIcon(image: UIImage(asset: ReJordUIAsset.secureGlanceOff)!)
    }
    self.configurateUI(inputType: inputType)
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Component Functions
  
  private func setImageIcon(image: UIImage) {
    self.signUpTextField.setupWithImage(image: UIImageView(image: image))
  }
  
  private func setTextUpperLabel(upperText: String) {
    self.upperLabel.text = upperText
  }
  
  
  // MARK: - Configure UI
  
  public func configurateUI(inputType: SignUpInputType) {
    baseView.snpLayout(baseView: self) { make in
      make.edges.equalToSuperview()
    }
    self.upperLabel.snpLayout(baseView: self.baseView, snpType: .remake) { make in
      make.top.leading.equalToSuperview()
    }
    switch inputType {
    case .withButton:
      self.duplicateInspectionButton.snpLayout(baseView: self.baseView) { make in
        make.top.equalTo(self.upperLabel.snp.bottom).offset(11)
        make.height.equalTo(40)
        make.width.equalTo(101)
        make.trailing.equalToSuperview()
      }
      self.signUpTextField.snpLayout(baseView: self.baseView) { make in
        make.centerY.equalTo(self.duplicateInspectionButton)
        make.leading.equalToSuperview()
        make.trailing.equalTo(self.duplicateInspectionButton.snp.leading).offset(-27)
      }
    case .withSecure:
      self.signUpTextField.snpLayout(baseView: self.baseView) { make in
        make.top.equalTo(self.upperLabel.snp.bottom).offset(11)
        make.leading.equalToSuperview()
        make.trailing.equalToSuperview()
      }
    }

  }
}
