//
//  UITextFIeld+Extension.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

extension UITextField {
  
  internal func setTextFieldOptions(
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
  
  internal func setPlaceHolder(text: String = "", color: UIColor = .black, font: UIFont) {
    self.attributedPlaceholder = NSAttributedString(
      string: text,
      attributes: [NSAttributedString.Key.foregroundColor : color,
                   NSAttributedString.Key.font : font]
    )
  }
  
  internal func setShadowAndBorder(shadowColor: UIColor, borderColor: UIColor) {
    self.layer.shadowColor = shadowColor.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.layer.shadowRadius = 5.0
    self.layer.shadowOpacity = 1.0
    self.layer.masksToBounds = false
    
    self.layer.borderColor = borderColor.cgColor
    self.layer.borderWidth = 1.0
  }
}
