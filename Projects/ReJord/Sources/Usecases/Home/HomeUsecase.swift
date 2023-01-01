//
//  HomeUsecase.swift
//  ReJord
//
//  Created by 송하민 on 2023/01/01.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import Foundation

final class HomeUsecase {
  
  let repository: HomeRepository
  
  init(repository: HomeRepository) {
    self.repository = repository
  }
  
  
}
