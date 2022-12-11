//
//  UITextFIeld+Extension.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

extension UITextField {
  
  func setTextFieldOptions(
    textColor: UIColor = .black,
    backgroundColor: UIColor = .white,
    font: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular),
    align: NSTextAlignment = .natural,
    keyboardType: UIKeyboardType = .default) {
      self.textColor = textColor
      self.backgroundColor = backgroundColor
      self.font = font
      self.textAlignment = align
      self.keyboardType = keyboardType
    }
  
  func setPlaceHolder(text: String = "", color: UIColor = .black) {
    self.attributedPlaceholder = NSAttributedString(
      string: text,
      attributes: [NSAttributedString.Key.foregroundColor : color]
    )
  }
}
