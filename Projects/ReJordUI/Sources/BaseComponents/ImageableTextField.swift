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

@objc protocol ImageableTextFieldDelegate: AnyObject {
  @objc optional func value(text: String?)
}

open class ImageableTextField: UITextField {
  
  
  // MARK: - Delegate
  
  weak var imageableDelegate: ImageableTextFieldDelegate?
  
  
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
  
  init() {
    super.init(frame: CGRect.zero)
    self.addTarget(self, action: #selector(test(_:)), for: .editingChanged)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func test(_ textField: UITextField) {
    self.imageableDelegate?.value?(text: self.text)
  }
  
  // MARK: - Left/Right Image
  
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
  
  var tapGesture: UITapGestureRecognizer? {
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


class ImageableTextFieldDelegateProxy: DelegateProxy<ImageableTextField, ImageableTextFieldDelegate>, DelegateProxyType, ImageableTextFieldDelegate {
  
  static func registerKnownImplementations() {
    self.register { (viewController) -> ImageableTextFieldDelegateProxy in
      ImageableTextFieldDelegateProxy(parentObject: viewController, delegateProxy: self)
    }
  }
  
  
  static func currentDelegate(for object: ImageableTextField) -> ImageableTextFieldDelegate? {
    return object.imageableDelegate
  }
  
  static func setCurrentDelegate(_ delegate: ImageableTextFieldDelegate?, to object: ImageableTextField) {
    object.imageableDelegate = delegate
  }
}

extension Reactive where Base == ImageableTextField {
  var imageableDelegate: DelegateProxy<ImageableTextField, ImageableTextFieldDelegate> {
    return ImageableTextFieldDelegateProxy.proxy(for: self.base)
  }

  var value: Observable<String?> {
    return imageableDelegate.methodInvoked(#selector(ImageableTextFieldDelegate.value(text:)))
      .map { param in
        return param[1] as? String? ?? ""
      }
  }
}
