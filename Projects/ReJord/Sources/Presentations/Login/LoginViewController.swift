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
  
  private let moveTestButton = UIButton().then { $0.backgroundColor = .blue }
  
  
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
