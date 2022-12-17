//
//  TextFieldWithImage.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/17.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

class ImageableTextField: UITextField {
  
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.leftViewRect(forBounds: bounds)
    textRect.origin.x += leftPadding
    return textRect
  }
  
  override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.leftViewRect(forBounds: bounds)
    textRect.origin.x -= rightPadding
    return textRect
  }
  
  var leftImage: UIImage? {
    didSet {
      updateView()
    }
  }
  var rightImage: UIImage? {
    didSet {
      updateView()
    }
  }
  
  var leftPadding: CGFloat = 0
  var rightPadding: CGFloat = 40
  
  func updateView() {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    
    if let image = leftImage {
      leftViewMode = UITextField.ViewMode.always
      leftView = imageView
      imageView.image = image
    }
    if let image = rightImage {
      rightViewMode = UITextField.ViewMode.always
      rightView = imageView
      imageView.image = image
    }
  
  }
}
