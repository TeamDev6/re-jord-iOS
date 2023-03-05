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
import SwiftyJSON

final class LoginRepositoryImplement: LoginRepository {
  
  var provider = NetworkProvider<ReJordAPI>()
  
  func login(id: String, password: String) -> Observable<Result<LoginResult, ReJordError>> {
		return provider.request(target: .login(id: id, password: password))
			.map { result in
				switch result {
					case .success(let data):
						let result = try JSONDecoder().decode(LoginResult.self, from: data)
						return .success(result)
					case .failure(let error):
						return .failure(error)
				}
			}
  }
  
  
    
}
