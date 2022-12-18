//
//  File.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import Moya

final class SignUpRepositoryImplement: SignUpRepository {
  
  var provider: MoyaProvider<ReJordAPI>
  
  init(networkProvider: MoyaProvider<ReJordAPI>) {
    self.provider = networkProvider
  }
  
  func signUp(userId: String, userPassword: String) {
    self.provider
      .request(.userSignUp(id: userId, pwd: userPassword), callbackQueue: .global()) { result in
        switch result {
        case .success(let data):
          print(data)
        case .failure(let error):
          print(error)
        }
      }
  }
}
