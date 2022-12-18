//
//  SignUpUsecase.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

final class SignUpUsecase {
  
  let repository: SignUpRepository
  
  init(repository: SignUpRepository) {
    self.repository = repository
  }
  
  func signUp(userId id: String, userPassword password: String) {
    self.repository.signUp(userId: id, userPassword: password)
  }
  
  
}
