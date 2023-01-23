//
//  PopNavigationButton.swift
//  ReJordUI
//
//  Created by 송하민 on 2023/01/23.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit

open class PopNavigationButton: UIButton {
  
  // MARK: - private properties
  
  var popTitle: String?
  
  
  // MARK: - life cycle
  
  public init(popTitle: String) {
    super.init(frame: CGRect.zero)
    self.popTitle = popTitle
    self.setupButton()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - set up
  
  public func setupButton() {
    self.setButtonProperties(
      backgroundColor: .clear,
      text: popTitle ?? "",
      textColor: .black,
      font: .roboto(fontType: .medium, fontSize: 13)
    )
    if #available(iOS 15.0, *) {
      self.setSideImage(
        on: .right,
        image: ReJordUIAsset.jumpUp.image,
        configuration: self.configuration,
        imagePadding: 11
      )
    }
  }
  
}
