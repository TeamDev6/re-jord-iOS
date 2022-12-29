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
  func signUp(userId: String, userPassword: String) -> Observable<Result<Data, ReJordError>>
  func checkId(id: String) -> Observable<Result<Data, ReJordError>>
  
}
