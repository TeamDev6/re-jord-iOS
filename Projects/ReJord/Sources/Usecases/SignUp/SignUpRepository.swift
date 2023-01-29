//
//  SignUpRepository.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import Foundation
import RxSwift

protocol SignUpRepository {
  func signUp(userId: String, userPassword: String) -> Observable<Result<SignUpResult, ReJordError>>
  func checkId(id: String) -> Observable<Result<Data, ReJordError>>
  func modifyUserInformation(nickname: String, uid: String) -> Observable<Result<Data, ReJordError>>
  
}

struct SignUpResult: Codable {
  let nickname: String
  let uid: String
  let userId: String
  let userType: String
}
