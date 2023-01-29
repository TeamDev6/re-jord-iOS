//
//  SignUpUsecase.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift

final class SignUpUsecase {
  
  let repository: SignUpRepository
  
  init(repository: SignUpRepository) {
    self.repository = repository
  }
  
  func signUp(userId id: String, userPassword password: String) -> Observable<Result<SignUpResult, ReJordError>> {
    return self.repository.signUp(userId: id, userPassword: password)
  }
  
  func checkIdDuplication(id: String) -> Observable<Result<Data, ReJordError>> {
    return self.repository.checkId(id: id)
  }
  
  func validateNickname(nickname: String?) -> Observable<Bool> {
    // TODO: 영문 대/소문자, 한글, 숫자 2~10 글자
    guard let nickname = nickname,
          (nickname.count >= 2 && nickname.count <= 10) else { return .just(false) }
    
    return .just(false)
  }
  
  func modifyUserInformation(nickname: String, uid: String) -> Observable<Result<Data, ReJordError>> {
    return self.repository.modifyUserInformation(nickname: nickname, uid: uid)
  }
  
}
