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
  
  func signUp(userId: String, userPassword: String) {
    print("userid ~> \(userId), userpwd ~> \(userPassword)")
    
    // network here
    MoyaProvider<ReJordAPI>().request(.userSignUp(id: userId, pwd: userPassword), callbackQueue: .global()) { result in
      print(result)
    }
  }
}
