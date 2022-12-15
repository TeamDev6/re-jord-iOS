//
//  ConfirmButton.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/13.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

open class ConfirmButton: UIButton {
  
  convenience public init(text: String) {
    self.init(frame: CGRect.zero)
    self.setupButton(titleText: text)
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupButton(titleText: String) {
    self.setButtonProperties(
      cornerRadius: 7,
      backgroundColor: .gray,
      text: titleText,
      textColor: .white,
      font: .roboto(fontType: .bold, fontSize: 20)
    )
  }
  
}
