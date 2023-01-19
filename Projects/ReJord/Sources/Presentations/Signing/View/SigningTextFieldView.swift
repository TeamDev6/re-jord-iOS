//
//  SignUpTextField.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/10.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReJordUI

@objc protocol SigningTextFieldViewDelegate: AnyObject {
  @objc optional func textInput(view: SigningTextFieldView, text: String?)
}

class SigningTextFieldView: UIView {
  
  // MARK: - Private Properties
  
  weak var delegate: SigningTextFieldViewDelegate?
  private let disposeBag = DisposeBag()
  private let tapGestrue = UITapGestureRecognizer()
  
  
  // MARK: - Compoenent
  
  public let baseTextField = ImageableTextField()
  
  
  // MARK: - Life Cycle
  
  
  public init(placeholderText text: String = "", image: UIImage? = nil, textSecure: Bool = false) {
    super.init(frame: .zero)
    
    self.setupBaseView()
    self.setupTextField(placeholderText: text, rightImage: image, isSecure: textSecure)
    self.setLayout()
    
    NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: self.baseTextField)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  // MARK: - private functions
  
  @objc private func textDidChange(_ notification: Notification) {
    guard let textField = notification.object as? UITextField else { return }
    self.delegate?.textInput?(view: self, text: textField.text)
  }
  
  private func setupBaseView() {
    self.layer.masksToBounds = false
    self.backgroundColor = .white
    self.layer.cornerRadius = 8
    self.layer.borderWidth = 0
    self.layer.borderColor = UIColor.gray.cgColor
    self.layer.shadowRadius = 4
    self.layer.shadowOpacity = 0.3
    self.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shouldRasterize = true
  }
  
  private func setupTextField(placeholderText: String, rightImage image: UIImage?, isSecure: Bool) {
    
    if isSecure {
      self.baseTextField.textContentType = .oneTimeCode
      self.baseTextField.isSecureTextEntry = true
      self.baseTextField.tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapAction))
    }
    self.setSignUpPlaceholder(
      newPlaceHolder: placeholderText,
      placeHolderColor: .gray,
      fontSize: 13
    )
    self.baseTextField.setTextFieldOptions(
      textColor: .black,
      backgroundColor: .white,
      font: .roboto(fontType: .medium, fontSize: 16),
      align: .left,
      keyboardType: .alphabet
    )
  
    self.baseTextField.rightPadding = 5
    self.baseTextField.rightImage = image
  }
  
  @objc func imageTapAction() {
    if let rightImage = self.baseTextField.rightImage {
      self.baseTextField.rightImage = rightImage
      self.baseTextField.togglePasswordVisibility()
    }
  }
  
  public func setSignUpPlaceholder(newPlaceHolder: String, placeHolderColor: UIColor, fontSize: CGFloat) {
    self.baseTextField.setPlaceHolder(
      text: newPlaceHolder,
      color: placeHolderColor,
      font: .roboto(fontType: .medium, fontSize: fontSize)
    )
  }
  
  private func setLayout() {
    self.baseTextField.snpLayout(baseView: self) { make in
      make.top.bottom.height.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(13)
    }
  }
  
}

class SigningTextFieldViewDelegateProxy: DelegateProxy<SigningTextFieldView, SigningTextFieldViewDelegate>, DelegateProxyType, SigningTextFieldViewDelegate {
  
  static func registerKnownImplementations() {
    self.register { (viewController) -> SigningTextFieldViewDelegateProxy in
      SigningTextFieldViewDelegateProxy(parentObject: viewController, delegateProxy: self)
    }
  }
  
  static func currentDelegate(for object: SigningTextFieldView) -> SigningTextFieldViewDelegate? {
    return object.delegate
  }
  
  static func setCurrentDelegate(_ delegate: SigningTextFieldViewDelegate?, to object: SigningTextFieldView) {
    return object.delegate = delegate
  }
  
}

extension Reactive where Base == SigningTextFieldView {
  
  var delegate: DelegateProxy<SigningTextFieldView, SigningTextFieldViewDelegate> {
    return SigningTextFieldViewDelegateProxy.proxy(for: self.base)
  }
  
  var textInput: Observable<String?> {
    return delegate.methodInvoked(#selector(SigningTextFieldViewDelegate.textInput(view:text:)))
      .map { params in
        return params[1] as? String
      }
  }
}

