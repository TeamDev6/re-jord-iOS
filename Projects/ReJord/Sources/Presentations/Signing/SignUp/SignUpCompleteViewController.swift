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
    $0.setStackArrangesView(subViews: [
      self.signUpCompleteLabel,
      self.nicknameInputStack,
      self.welcomeCompleteLabel
    ])
  }
  private let signUpCompleteLabel: UILabel = UILabel().then {
    $0.font = .roboto(fontType: .bold, fontSize: 30)
    $0.text = ReJordUIStrings.signUpCompleteSignUpComplete
    $0.textColor = ReJordUIAsset.mainGreen.color
  }
  private lazy var nicknameInputStack = UIStackView().asHorizontal(
    distribution: .fill,
    alignment: .fill,
    spacing: 5.0
  ).then { (stackView: UIStackView) in
    self.suffixOfNickname.setContentCompressionResistancePriority(
      .defaultHigh,
      for: .horizontal
    )
    self.nicknameFieldView.setContentHuggingPriority(
      .defaultHigh,
      for: .horizontal
    )
    stackView.setStackArrangesView(subViews: [
      self.nicknameFieldView,
      self.suffixOfNickname
    ])
  }
  private lazy var nicknameFieldView = NicknameTextFieldView()
  private let suffixOfNickname = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .bold, fontSize: 26)
    label.text = ReJordUIStrings.signUpCompleteSir
    label.textColor = .black
  }
  private let welcomeCompleteLabel: UILabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .bold, fontSize: 26)
    label.text = ReJordUIStrings.signUpCompleteWelcome
    label.textColor = .black
  }
  private lazy var nicknameValidationStackView = UIStackView().asVertical(
    distribution: .fill,
    alignment: .fill,
    spacing: 8
  ).then { (stackView: UIStackView) in
    stackView.backgroundColor = .clear
    stackView.setStackArrangesView(subViews: [
      self.nicknameValidationLabel,
      self.nicknameValidationDescriptionLabel
    ])
  }
  private let nicknameValidationLabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .medium, fontSize: 16)
    label.textColor = .gray
  }
  private let nicknameValidationDescriptionLabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .medium, fontSize: 16)
    label.textColor = .gray
    label.text = ReJordUIStrings.signUpCompleteRestriction
    label.numberOfLines = 2
  }
  private let confirmButton = ConfirmButton(text: ReJordUIStrings.signUpCompleteRegisterComplete)
  
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - private functions
  
  private func setTextOnNicknameValidationLabel(status: NickNameStatusType) {
    var settableString: String = ""
    switch status {
    case .empty:
      settableString = ReJordUIStrings.signUpCompleteRegisterNickname
    case .duplicated:
      settableString = ReJordUIStrings.signUpCompleteAlreadyUsedNickname
    case .invalidCount:
      settableString = ReJordUIStrings.signUpCompleteInvalidNickname
    case .valid:
      settableString = ReJordUIStrings.signUpCompleteUsableNickname
    }
    self.nicknameValidationLabel.text = settableString
  }
  
  private func setColorOnValidationLabel(status: NickNameStatusType) {
    var settableColor: UIColor = .clear
    switch status {
    case .empty:
      settableColor = .gray
    case .duplicated:
      settableColor = ReJordUIAsset.warningRed.color
    case .invalidCount:
      settableColor = ReJordUIAsset.warningRed.color
    case .valid:
      settableColor = ReJordUIAsset.mainGreen.color
    }
    self.nicknameValidationLabel.textColor = settableColor
  }
  
  private func configureNavigationBar() {
    self.navigationItem.setHidesBackButton(true, animated: false)
    let pushNav = PushNavigationButton(pushTitle: ReJordUIStrings.navigationItemJumpUp)
    pushNav.addTarget(self, action: #selector(rightNavigationAction), for: .touchUpInside)
    self.navigationItem.rightBarButtonItem = pushNav.toBarButtonItem()
    
  }
  
  @objc func rightNavigationAction() {
    self.reactor?.steps.accept(ReJordSteps.homeSceneIsRequired)
  }
  
  
  // MARK: - life cycles
  
  init(reactor: SignUpReactor) {
    super.init(nibName: nil, bundle: nil)
    self.configureNavigationBar()
    self.setLayout()
    self.reactor = reactor
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
      self.nicknameInputStack.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview()
        self.nicknameFieldView.snp.makeConstraints { make in
          make.leading.equalToSuperview()
        }
        self.suffixOfNickname.snp.makeConstraints { make in
          make.trailing.equalToSuperview()
          make.height.equalTo(44)
        }
      }
    }
    self.nicknameValidationStackView.snpLayout(baseView: self.baseView) { make in
      make.top.equalTo(self.welcomeStack.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview()
    }
    self.confirmButton.snpLayout(baseView: self.baseView) { make in
      make.bottom.leading.trailing.equalToSuperview()
      make.height.equalTo(47)
    }
  }
  
  
  
  // MARK: - bind reactor
  
  func bind(reactor: SignUpReactor) {

    // state
    
    self.reactor?.state
      .map { $0.nicknameStatus }
      .asDriver(onErrorJustReturn: .empty)
      .drive(onNext: { [weak self] nicknameStatus in
        self?.setTextOnNicknameValidationLabel(status: nicknameStatus)
        self?.setColorOnValidationLabel(status: nicknameStatus)
      })
      .disposed(by: self.disposeBag)
    
    self.reactor?.state
      .map { $0.defaultNickname }
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] defaultNickname in
        self?.nicknameFieldView.setTextOnNicknameTextField(text: defaultNickname)
      })
      .disposed(by: self.disposeBag)
    
    
    
    // action
    
    self.nicknameFieldView.rx.textInput
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] text in
        // TODO: text validation
        print(text)
      })
      .disposed(by: self.disposeBag)
   
    self.confirmButton.rx.tap
      .asDriver(onErrorJustReturn: ())
      .drive(onNext: { [weak self] text in
        
//        self?.reactor?.action.onNext(.nickNameValueInserted(
//          text: text,
//          signUpResult: signUpResult)
//        )
      })
      .disposed(by: self.disposeBag)
    
  }
}
