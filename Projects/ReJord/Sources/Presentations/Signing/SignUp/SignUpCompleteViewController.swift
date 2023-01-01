//
//  SignUpCompleteViewController.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/29.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import ReJordUI

final class SignUpCompleteViewController: UIViewController, Layoutable, View {
  
  
  // MARK: - components
  
  
  
  // MARK: - component options
  
  
  // MARK: - private properties
  
  
  // MARK: - private functions
  
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycles
  
  init(reactor: SignUpReactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.configureNavigationBar()
    self.setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("\(self) is deinited")
  }
  
  
  // MARK: - layout
  
  func setLayout() {
    
  }
  
  private func configureNavigationBar() {
    DispatchQueue.main.async {
      self.navigationItem.setHidesBackButton(true, animated: false)
      self.navigationItem.rightBarButtonItem = self.addRightBarButton().toBarButtonItem()
    }
  }
  
  private func addRightBarButton() -> UIButton {
    return UIButton().then {
      $0.setButtonProperties(
        backgroundColor: .clear,
        text: ReJordUIStrings.jumpUp,
        textColor: .black,
        font: .roboto(fontType: .medium, fontSize: 13)
      )
      if #available(iOS 15.0, *) {
        $0.setSideImage(
          on: .right,
          image: ReJordUIAsset.jumpUp.image,
          configuration: $0.configuration,
          imagePadding: 11
        )
      } else {
        $0.setSideImage(
          on: .right,
          image: ReJordUIAsset.secureGlanceOff.image,
          contentInsets: UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
        )
      }
      $0.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
    }
  }
  @objc func rightButtonAction() {
    print("aaaaa")
  }
  
  
  // MARK: - bind reactor
  
  func bind(reactor: SignUpReactor) {
    
  }
  
  
  
  
}
