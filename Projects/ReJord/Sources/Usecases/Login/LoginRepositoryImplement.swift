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
    
}
