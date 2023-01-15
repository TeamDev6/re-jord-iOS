//
//  LoginUsecase.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/30.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift

final class LoginUsecase {
  
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
  
  
}
