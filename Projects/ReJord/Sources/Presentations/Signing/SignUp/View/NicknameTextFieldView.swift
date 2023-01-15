//
//  NicknameTextFieldView.swift
//  ReJord
//
//  Created by 송하민 on 2023/01/12.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit
import SnapKit
import Then
import ReJordUI
import RxSwift
import RxCocoa

@objc protocol NickNameTextFieldViewDelegate: AnyObject {
  @objc optional func textInput(view: NicknameTextFieldView, value: String?)
}

final class NicknameTextFieldView: UIView {
  
  weak var delegate: NickNameTextFieldViewDelegate?
  
  // MARK: - components
  
  private let baseView: UIView = UIView().then { (view: UIView) in
    view.addBorder(edge: .bottom, color: ReJordUIAsset.mainGreen.color, thickness: 2)
    view.backgroundColor = .white
  }
  
  private lazy var nicknameTextField = UITextField().then { (textField: UITextField) in
    textField.setTextFieldOptions(textColor: .black, backgroundColor: .clear, font: .roboto(fontType: .bold, fontSize: 26), align: .left, keyboardType: .default)
    textField.setPlaceHolder(text: "닉네임을 등록해주세요.", color: .gray, font: .roboto(fontType: .bold, fontSize: 26))
  }
  
  
  // MARK: - private func
  
  @objc private func textDidChange(_ notification: Notification) {
    self.delegate?.textInput?(view: self, value: self.nicknameTextField.text)
  }
  
  
  // MARK: - life cycle
  
  init() {
    super.init(frame: .zero)
    self.layout()
    NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: self.nicknameTextField)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  
  // MARK: - layout
  
  private func layout() {
    self.baseView.snpLayout(baseView: self) { make in
      make.edges.equalToSuperview()
      make.height.equalTo(52)
      make.width.equalTo(self.nicknameTextField.intrinsicContentSize.width)
    }
    self.nicknameTextField.snpLayout(baseView: self.baseView) { make in
      make.bottom.equalToSuperview().inset(8)
      make.leading.trailing.equalToSuperview()
    }
  }

}

class NickNameTextFieldViewDelegateProxy: DelegateProxy<NicknameTextFieldView, NickNameTextFieldViewDelegate>, DelegateProxyType, NickNameTextFieldViewDelegate {
  static func registerKnownImplementations() {
    self.register { (viewController) -> NickNameTextFieldViewDelegateProxy in
      NickNameTextFieldViewDelegateProxy(parentObject: viewController, delegateProxy: self)
    }
  }
  
  static func currentDelegate(for object: NicknameTextFieldView) -> NickNameTextFieldViewDelegate? {
    return object.delegate
  }
  
  static func setCurrentDelegate(_ delegate: NickNameTextFieldViewDelegate?, to object: NicknameTextFieldView) {
    return object.delegate = delegate
  }
}

extension Reactive where Base == NicknameTextFieldView {
  
  var delegate: DelegateProxy<NicknameTextFieldView, NickNameTextFieldViewDelegate> {
    return NickNameTextFieldViewDelegateProxy.proxy(for: self.base)
  }
  
  var textInput: Observable<String?> {
    return delegate.methodInvoked(#selector(NickNameTextFieldViewDelegate.textInput(view:value:)))
      .map { params in
        return params[1] as? String
      }
  }
  
}
