//
//  File.swift
//  ReJord
//
//  Created by 송하민 on 2023/01/01.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit
import Moya
import RxSwift

final class HomeRepositoryImplemenet: HomeRepository {
  
  var provider = NetworkProvider<ReJordAPI>()
  
}
