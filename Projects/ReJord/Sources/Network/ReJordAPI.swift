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
  case idValidate(id: String)
}

extension ReJordAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://leadpet-dev6.com")!
  }
  
  var path: String {
    switch self {
    case .userSignUp:
      return "/v1/users"
    case .idValidate(id: let id):
      return "/v1/users/\(id)/duplication"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .userSignUp:
      return .post
    case .idValidate:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .userSignUp(let id, let pwd):
      let params: [String: Any] = ["userId": id, "password": pwd, "userType": "BASIC"]
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    case .idValidate:
      return .requestPlain
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
    case .idValidate:
      return header
    }
  }
  
  
}
