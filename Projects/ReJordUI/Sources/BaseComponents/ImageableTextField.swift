//
//  TextFieldWithImage.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/17.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class ImageableTextField: UITextField {
  
  
  // MARK: - Life Cycle
  
  open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.leftViewRect(forBounds: bounds)
    textRect.origin.x += leftPadding
    return textRect
  }

  open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.rightViewRect(forBounds: bounds)
    textRect.origin.x -= rightPadding
    return textRect
  }
  
  public init() {
    super.init(frame: CGRect.zero)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Left/Right Image
  
  public var leftImage: UIImage? {
    didSet {
      updateView()
    }
  }
  public var rightImage: UIImage? {
    didSet {
      updateView()
    }
  }
  
  public var tapGesture: UITapGestureRecognizer? {
    didSet {
      if rightImage != nil {
        updateView()
      }
    }
  }
  
  internal var leftPadding: CGFloat = 0
  internal var rightPadding: CGFloat = 0
  
  private func updateView() {
    
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
      guard let tapGesture else { return }
      imageView.isUserInteractionEnabled = true
      imageView.addGestureRecognizer(tapGesture)
    }
  }
  
}
