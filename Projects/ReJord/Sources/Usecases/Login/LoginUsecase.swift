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
  
  let repository: LoginRepository
  
  init(repository: LoginRepository) {
    self.repository = repository
  }
  
  func login(id: String, password: String) -> Observable<Result<Data, ReJordError>> {
    return self.repository.login(id: id, password: password)
  }
  
  
}
