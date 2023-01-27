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
  case modifyUserInfo(nickname: String, uid: String)
  case login(id: String, password: String)
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
    case .modifyUserInfo(_, let uid):
      return "/v1/users/\(uid)"
    case .login:
      return "/v1/login"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .userSignUp:
      return .post
    case .idValidate:
      return .get
    case .modifyUserInfo:
      return .patch
    case .login:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .userSignUp(let id, let pwd):
      let params: [String: Any] = ["userId": id, "password": pwd, "userType": "BASIC"]
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    case .idValidate:
      return .requestPlain
    case .modifyUserInfo(let nickname, _):
      return .requestParameters(parameters: ["nickname": nickname], encoding: JSONEncoding.default)
    case .login(id: let id, password: let password):
      return .requestParameters(parameters: ["userId": id, "password": password], encoding: JSONEncoding.default)
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
    case .modifyUserInfo:
      return header
    case .login:
      return header
    }
  }
  
  
}
