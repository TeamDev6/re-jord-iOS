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

final class SignUpCompleteViewController: UIViewController, Layoutable, View, UITextFieldDelegate {
  
  
  // MARK: - components
  
  private let backgroundView: UIView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let baseView: UIView = UIView().then {
    $0.backgroundColor = .clear
  }
  
  private lazy var welcomeStack = UIStackView().asVertical(distribution: .fill, alignment: .leading, spacing: 30).then {
    $0.setStackArrangesView(subViews: [self.signUpCompleteLabel, self.nicknameStack, self.welcomeCompleteLabel])
  }
  private let signUpCompleteLabel: UILabel = UILabel().then {
    $0.font = .roboto(fontType: .bold, fontSize: 30)
    $0.text = "회원가입 완료! 👋"
    $0.textColor = ReJordUIAsset.mainGreen.color
  }
  private lazy var nicknameStack = UIStackView().asHorizontal(distribution: .fill, alignment: .fill, spacing: 5.0).then { (stackView) in
    self.suffixOfNickname.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    self.nicknameFieldView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    stackView.setStackArrangesView(subViews: [self.nicknameFieldView, self.suffixOfNickname])
  }
  private lazy var nicknameFieldView = NicknameTextFieldView()
  private let suffixOfNickname = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .bold, fontSize: 26)
    label.text = "님"
    label.textColor = .black
  }
  private let welcomeCompleteLabel: UILabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .bold, fontSize: 26)
    label.text = "반갑습니다 :)"
    label.textColor = .black
  }
  
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
    self.backgroundView.snpLayout(baseView: self.view) { make in
      make.edges.equalToSuperview()
    }
    self.baseView.snpLayout(baseView: self.backgroundView) { make in
      let safeGuide = self.view.safeAreaLayoutGuide
      make.top.bottom.equalTo(safeGuide)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    self.welcomeStack.snpLayout(baseView: self.baseView) { make in
      make.top.equalToSuperview().inset(45)
      make.leading.trailing.equalToSuperview()
      
      self.signUpCompleteLabel.snp.makeConstraints { make in
        make.leading.equalToSuperview()
      }
    }
    self.nicknameStack.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      self.nicknameFieldView.snp.makeConstraints { make in
        make.leading.equalToSuperview()
      }
      self.suffixOfNickname.snp.makeConstraints { make in
        make.trailing.equalToSuperview()
      }
    }
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
