//
//  File.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import Moya
import RxSwift

final class SignUpRepositoryImplement: SignUpRepository {
  
  var provider = NetworkProvider<ReJordAPI>()
    
  func signUp(userId: String, userPassword: String) -> Observable<Result<Data, ReJordError>> {
    return self.provider
      .request(target: .userSignUp(id: userId, pwd: userPassword))
      .map({ result in
        switch result {
        case .success(let data):
          return .success(data)
        case .failure(let error):
          return .failure(error)
        }
      })
  }
  
  func checkId(id: String) -> Observable<Result<Data, ReJordError>> {
    return self.provider
      .request(target: .idValidate(id: id))
      .map { result in
        switch result {
        case .success(let data):
          return .success(data)
        case .failure(let error):
          return .failure(error)
        }
      }
  }
  
  func checkNickname(nickname: String) -> Observable<Result<Data, ReJordError>> {
    return self.provider
      .request(target: .nicknameValidate(nickname: nickname))
      .map { result in
        switch result {
        case .success(let data):
          print(data)
          return .success(data)
        case .failure(let error):
          return .failure(error)
        }
      }
  }
  
  
  
}
