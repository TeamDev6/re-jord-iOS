//
//  ConfirmButton.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/13.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@objc protocol ConfirmButtonDelegate: AnyObject {
  @objc optional func tapped(view: ConfirmButton)
}

open class ConfirmButton: UIButton {
  
  weak var delegate: ConfirmButtonDelegate?
  
  // MARK: - Life Cycle
  
  convenience public init(text: String) {
    self.init(frame: CGRect.zero)
    self.setupButton(titleText: text)
    self.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Functions
  
  @objc func tapAction() {
    self.delegate?.tapped?(view: self)
  }
  
  private func setupButton(titleText: String) {
    self.setButtonProperties(
      cornerRadius: 7,
      backgroundColor: ReJordUIAsset.mainGreen.color,
      text: titleText,
      textColor: .white,
      font: .roboto(fontType: .bold, fontSize: 20)
    )
  }
  
}

class ConfirmButtonDelegateProxy: DelegateProxy<ConfirmButton, ConfirmButtonDelegate>, DelegateProxyType, ConfirmButtonDelegate {
  
  static func registerKnownImplementations() {
    self.register { (viewController) -> ConfirmButtonDelegateProxy in
      ConfirmButtonDelegateProxy(parentObject: viewController, delegateProxy: self)
    }
  }
  
  static func currentDelegate(for object: ConfirmButton) -> ConfirmButtonDelegate? {
    return object.delegate
  }
  
  static func setCurrentDelegate(_ delegate: ConfirmButtonDelegate?, to object: ConfirmButton) {
    object.delegate = delegate
  }
}

extension Reactive where Base == ConfirmButton {
  var delegate: DelegateProxy<ConfirmButton, ConfirmButtonDelegate> {
    return ConfirmButtonDelegateProxy.proxy(for: self.base)
  }

  var tapped: Observable<Void> {
    return delegate.methodInvoked(#selector(ConfirmButtonDelegate.tapped(view:)))
      .map { param in
        return
      }
  }
}
