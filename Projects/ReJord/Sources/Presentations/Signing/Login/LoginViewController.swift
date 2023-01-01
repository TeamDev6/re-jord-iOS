//
//  LoginViewController.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/30.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import ReJordUI

final class LoginViewController: UIViewController, Layoutable, View {
  
  
  
  // MARK: - components
  
  // test
  private let moveTestButton = UIButton().then { $0.backgroundColor = .blue }
  
  private var baseView: UIView = {
    let view = UIView()
    return view
  }()
  
  private let loginTitleLabel = UILabel().then { (label: UILabel) in
    label.text = "로그인"
    label.font = .roboto(fontType: .bold, fontSize: 24)
    label.textColor = .black
  }
  
  private let loginSubTitleLabel = UILabel().then { (label: UILabel) in
    label.text = ""
    label.numberOfLines = 2
    label.font = .roboto(fontType: .medium, fontSize: 16)
    label.textColor = .gray
  }
  
  private lazy var idInputView: SignUpTextFieldInputView = { [weak self] in
    guard let self,
          let reactor = self.reactor else {
      return SignUpTextFieldInputView(frame: .zero)
    }
    return SignUpTextFieldInputView(frame: .zero)
//    return TextFieldInputView(reactor: reactor, upperLabelText: "", inputType: .id)
  }()
  
  
  // MARK: - component options
  
  
  // MARK: - private properties
  
  
  // MARK: - private functions
  
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycles
  
  init(reactor: LoginReactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setLayout()
    self.view.backgroundColor = .gray
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - layout
  
  func setLayout() {
    self.moveTestButton.snpLayout(baseView: self.view) { make in
      make.centerX.centerY.equalToSuperview()
      make.width.height.equalTo(120)
    }
  }
  
  
  // MARK: - bind reactor
  
  func bind(reactor: LoginReactor) {
    self.moveTestButton.rx.tap
      .subscribe(onNext: { _ in
        self.reactor?.action.onNext(.gotoSignUpScene)
      })
      .disposed(by: self.disposeBag)
  }
  
  
  
  
}
