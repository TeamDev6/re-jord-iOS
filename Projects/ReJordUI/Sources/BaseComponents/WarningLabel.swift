//
//  WarningLabel.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

open class WarningLabel: UILabel {
  
  convenience public init(text: String, font: UIFont, color: UIColor = .black) {
    self.init(frame: CGRect.zero)
    self.setupLabel(labelText: text, font: font, color: color)
    self.sizeToFit()
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLabel(labelText: String, font: UIFont, color: UIColor) {
    self.font = font
    self.textColor = color
    self.text = labelText
    self.numberOfLines = 1
  }
  
}
