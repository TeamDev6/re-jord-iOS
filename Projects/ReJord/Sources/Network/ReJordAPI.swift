//
//  ReJordAPI.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/12.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import Moya

enum ReJordAPI {
  case userSignUp(id: String, pwd: String)
}

extension ReJordAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://leadpet-dev6.com")!
  }
  
  var path: String {
    switch self {
    case .userSignUp:
      return "/v1/users"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .userSignUp:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .userSignUp(let id, let pwd):
      let params: [String: Any] = ["userId": id, "password": pwd, "userType": "BASIC"]
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
  }
  var validationType: ValidationType {
    return .successAndRedirectCodes
  }
  
  var headers: [String : String]? {
    var header: [String: String] = [:]
    header["Content-Type"] = "application/json; charset=utf-8"
    switch self {
    case .userSignUp:
      return header
    }
  }
  
  
}
