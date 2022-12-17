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

public enum ImageLocateType {
  case left
  case right
}

open class SignUpTextFieldView: UIView {
  
  
  // MARK: - Private Properties
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Compoenent
  
  let baseTextField = ImageableTextField()
  
  
  // MARK: - Life Cycle
  
  
  init(placeholderText text: String = "", image: UIImage) {
    super.init(frame: .zero)
    self.setup(placeholderText: text, rightImage: image)
    self.setLayout()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Set up
  
  private func setup(placeholderText: String, rightImage image: UIImage) {
    self.setSignUpPlaceholder(newPlaceHolder: placeholderText, placeHolderColor: .gray)
    self.baseTextField.setTextFieldOptions(
      textColor: .black,
      backgroundColor: .white,
      font: .roboto(fontType: .medium, fontSize: 16),
      align: .left,
      keyboardType: .alphabet
    )
    self.layer.borderWidth = 2
    self.layer.cornerRadius = 8.0
    self.baseTextField.rightPadding = 20
    self.baseTextField.rightImage = image
  }
  
  public func setSignUpPlaceholder(newPlaceHolder: String, placeHolderColor: UIColor) {
    self.baseTextField.setPlaceHolder(
      text: newPlaceHolder,
      color: placeHolderColor,
      font: .roboto(fontType: .medium, fontSize: 13)
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
