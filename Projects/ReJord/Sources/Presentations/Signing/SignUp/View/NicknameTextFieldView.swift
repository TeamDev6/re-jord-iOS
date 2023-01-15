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
import ReactorKit
import ReJordUI

final class NicknameTextFieldView: UIView, View, UITextFieldDelegate {
  
  private let baseView: UIView = UIView().then { (view: UIView) in
    view.addBorder(edge: .bottom, color: ReJordUIAsset.mainGreen.color, thickness: 2)
    view.backgroundColor = .white
  }
  
  private lazy var nicknameTextField = UITextField().then { (textField: UITextField) in
    textField.setTextFieldOptions(textColor: .black, backgroundColor: .clear, font: .roboto(fontType: .bold, fontSize: 26), align: .left, keyboardType: .default)
    textField.setPlaceHolder(text: "닉네임을 등록해주세요.", color: .gray, font: .roboto(fontType: .bold, fontSize: 26))
  }
  
  var disposeBag: DisposeBag = DisposeBag()
  
  init() {
    super.init(frame: .zero)
    self.layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
  
  func bind(reactor: SignUpReactor) {
    self.nicknameTextField.rx.text
      .asDriver()
      .drive(onNext: { [weak self] text in
        self?.reactor?.action.onNext(.nickNameValueInserted(text: text))
      })
      .disposed(by: self.disposeBag)
  }
  
}
