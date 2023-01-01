//
//  SignUpTextField.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/10.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReJordUI

open class SigningTextFieldView: UIView {
  
  // MARK: - Private Properties
  
  private let disposeBag = DisposeBag()
  private let tapGestrue = UITapGestureRecognizer()
  
  
  // MARK: - Compoenent
  
  public let baseTextField = ImageableTextField()
  
  
  // MARK: - Life Cycle
  
  
  public init(placeholderText text: String = "", image: UIImage? = nil, textSecure: Bool = false) {
    super.init(frame: .zero)
    self.setup(placeholderText: text, rightImage: image, isSecure: textSecure)
    self.setLayout()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Set up
  
  private func setup(placeholderText: String, rightImage image: UIImage?, isSecure: Bool) {
    if isSecure {
      self.baseTextField.textContentType = .oneTimeCode
      self.baseTextField.isSecureTextEntry = true
      self.baseTextField.tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapAction))
    }
    self.setSignUpPlaceholder(
      newPlaceHolder: placeholderText,
      placeHolderColor: .gray,
      fontSize: 13
    )
    self.baseTextField.setTextFieldOptions(
      textColor: .black,
      backgroundColor: .white,
      font: .roboto(fontType: .medium, fontSize: 16),
      align: .left,
      keyboardType: .alphabet
    )
    self.layer.borderWidth = 2
    self.layer.cornerRadius = 8.0
    self.baseTextField.rightPadding = 30
    self.baseTextField.rightImage = image
  }
  
  @objc func imageTapAction() {
    if let rightImage = self.baseTextField.rightImage {
      self.baseTextField.rightImage = rightImage
      self.baseTextField.togglePasswordVisibility()
    }
  }
  
  public func setSignUpPlaceholder(newPlaceHolder: String, placeHolderColor: UIColor, fontSize: CGFloat) {
    self.baseTextField.setPlaceHolder(
      text: newPlaceHolder,
      color: placeHolderColor,
      font: .roboto(fontType: .medium, fontSize: fontSize)
    )
  }
  
  private func setLayout() {
    self.baseTextField.snpLayout(baseView: self) { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalToSuperview().inset(13)
      make.width.height.equalToSuperview()
    }
  }
  
}