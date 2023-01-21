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
  private lazy var nicknameValidationStackView = UIStackView().asVertical(distribution: .fill, alignment: .fill).then { (stackView: UIStackView) in
    stackView.backgroundColor = .clear
    stackView.setStackArrangesView(subViews: [self.nicknameValidationLabel, self.nicknameValidationDescriptionLabel])
  }
  private let nicknameValidationLabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .medium, fontSize: 16)
    label.textColor = .gray
  }
  private let nicknameValidationDescriptionLabel = UILabel().then { (label: UILabel) in
    label.font = .roboto(fontType: .medium, fontSize: 16)
    label.textColor = .gray
    label.text = "닉네임은 영문 대/소문자, 한글, 숫자로 등록 가능하며,\n최소 2글자~최대 10글자까지 등록 가능합니다."
    label.numberOfLines = 2
  }
  private let confirmButton = ConfirmButton(text: "등록완료")
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - private functions
  
  private func setTextOnNicknameValidationLabel(status: NickNameStatusType) {
    var settableString: String = ""
    switch status {
    case .empty:
      settableString = "닉네임을 등록해보세요."
    case .duplicated:
      settableString = "이미 사용중인 닉네임입니다."
    case .invalidCount:
      settableString = "형식에 맞지 않은 닉네임입니다."
    case .valid:
      settableString = "사용가능한 닉네임입니다."
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
  
  // MARK: - private properties
  
  var signUpResult: SignUpResult?
  
  
  // MARK: - life cycles
  
  init(reactor: SignUpReactor, signUpResult: SignUpResult) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
    self.signUpResult = signUpResult
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
    self.nicknameValidationStackView.snpLayout(baseView: self.baseView) { make in
      make.top.equalTo(self.welcomeStack.snp.bottom).offset(20)
      make.leading.trailing.equalToSuperview()
    }
    self.confirmButton.snpLayout(baseView: self.baseView) { make in
      make.bottom.leading.trailing.equalToSuperview()
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
    
    // action
    
    self.nicknameFieldView.rx.textInput
      .debounce(.seconds(2), scheduler: MainScheduler.asyncInstance)
      .asDriver(onErrorJustReturn: "")
      .drive(onNext: { [weak self] text in
        guard let signUpResult = self?.signUpResult else { return }
        self?.reactor?.action.onNext(.nickNameValueInserted(text: text, signUpResult: signUpResult))
      })
      .disposed(by: self.disposeBag)
  }
  
  
  
  
}
