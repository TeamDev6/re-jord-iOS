//
//  LoginRepository.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/30.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginRepository {
  func login(id: String, password: String) -> Observable<Result<LoginResult, ReJordError>>
}

struct LoginResult: Codable {
	let nickname: String
	let roles: [String]
	let tokens: Tokens
	let uid, userID: String
	
	enum CodingKeys: String, CodingKey {
		case nickname, roles, tokens, uid
		case userID = "userId"
	}
}

struct Tokens: Codable {
	let accessToken, refreshToken: String
}

