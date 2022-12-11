//
//  SignUpTextField.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/10.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import SnapKit

open class SignUpTextField: UITextField {
  
  convenience public init(placeholderText text: String) {
    self.init(frame: CGRect.zero)
    self.setup(placeholderText: text)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 10.0, dy: 10.0)
  }
  
  private func setup(placeholderText: String) {
    self.setPlaceHolder(text: placeholderText, color: .black)
    self.setTextFieldOptions(
      textColor: .black,
      backgroundColor: .white,
      font: .roboto(font: .medium, fontSize: 14),
      align: .left,
      keyboardType: .alphabet
    )
    self.setShadowAndBorder(shadowColor: .gray, borderColor: .gray)
    self.layer.cornerRadius = 8.0
    
  }
}
