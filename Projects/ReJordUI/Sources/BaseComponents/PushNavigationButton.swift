//
//  PushPopNavigationButton.swift
//  ReJordUI
//
//  Created by 송하민 on 2023/01/23.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit

open class PushNavigationButton: UIButton {
  
  
  // MARK: - private properties
  
  var pushTitle: String?
  
  
  // MARK: - life cycle
  
  public init(pushTitle: String) {
    super.init(frame: CGRect.zero)
    self.pushTitle = pushTitle
    self.setupButton()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - setup
    
  public func setupButton() {
    self.setButtonProperties(
      backgroundColor: .clear,
      text: pushTitle ?? "",
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
