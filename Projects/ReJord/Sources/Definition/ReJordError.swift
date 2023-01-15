//
//  ReJordError.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import Foundation

enum ErrorFrom {
  case server
}

enum ReJordError: Error {
  case serverError
  case cantBindReactor
  case jsonDecodingFail
}

