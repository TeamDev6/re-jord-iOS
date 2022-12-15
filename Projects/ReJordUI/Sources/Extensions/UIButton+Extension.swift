//
//  UIButton+Extension.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/13.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

extension UIButton {
  
  internal func setButtonProperties(cornerRadius: CGFloat, backgroundColor: UIColor, text: String, textColor: UIColor, font: UIFont) {
    self.layer.cornerRadius = cornerRadius
    self.backgroundColor = backgroundColor
    self.setTitle(text, for: .normal)
    self.setTitleColor(textColor, for: .normal)
    self.titleLabel?.font = font
  }
}
