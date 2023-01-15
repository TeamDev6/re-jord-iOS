//
//  LoginRepositoryImplement.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/30.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import Moya
import RxSwift

final class LoginRepositoryImplement: LoginRepository {
  
  var provider = NetworkProvider<ReJordAPI>()
  
  func login(id: String, password: String) -> Observable<Result<Data, ReJordError>> {
    return provider.request(target: .login(id: id, password: password))
      .map { result in
        switch result {
        case .success(let data):
          return .success(data)
        case .failure(let error):
          return .failure(error)
        }
      }
  }
  
  
    
}
