//
//  UIButton+Extension.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/13.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

public enum ButtonImageSide {
  case left
  case right
}

extension UIButton {
  
  public func setButtonProperties(
    cornerRadius: CGFloat = 0,
    backgroundColor: UIColor,
    text: String,
    textColor: UIColor,
    font: UIFont) {
      if #available(iOS 15.0, *) {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = backgroundColor
        configuration.title = text
        configuration.buttonSize = .medium
        configuration.background.cornerRadius = cornerRadius
        configuration.cornerStyle = .fixed
        var attrTitle = AttributedString(text)
        attrTitle.font = font
        attrTitle.foregroundColor = textColor
        configuration.attributedTitle = attrTitle
        self.configuration = configuration
      } else {
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
      }
    }
  
  public func setSideImage(
    on: ButtonImageSide,
    image: UIImage,
    configuration: UIButton.Configuration? = nil,
    configurationDirection: NSDirectionalEdgeInsets? = nil,
    imagePadding: CGFloat = 0,
    titlePadding: CGFloat = 0,
    contentInsets: UIEdgeInsets = .zero,
    titleInsets: UIEdgeInsets = .zero) {
  
      self.setImage(image, for: .normal)
      
      if #available(iOS 15.0, *) {
        guard var configuration else { return }
        if let configurationDirection {
          configuration.contentInsets = configurationDirection
        }
        configuration.imagePlacement = on == .left ? .leading : .trailing
        configuration.imagePadding = imagePadding
        configuration.titlePadding = titlePadding
        self.configuration = configuration
      } else {
        self.semanticContentAttribute = on == .left ? .forceLeftToRight : .forceRightToLeft
        self.contentEdgeInsets = contentInsets
        self.titleEdgeInsets = titleInsets
      }
  }
  
  public func toBarButtonItem() -> UIBarButtonItem? {
    self.sizeToFit()
    return UIBarButtonItem(customView: self)
  }
}
