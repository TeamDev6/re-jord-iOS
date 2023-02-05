//
//  MainTabbarStpper.swift
//  ReJord
//
//  Created by 송하민 on 2023/02/05.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import RxFlow
import RxCocoa
import RxFlow

class MainTabbarStepper: Stepper {
  var steps: PublishRelay<Step> {
    PublishRelay<Step>()
  }
  var initialStep: Step {
    return ReJordSteps.homeTabIsRequired
  }
}
