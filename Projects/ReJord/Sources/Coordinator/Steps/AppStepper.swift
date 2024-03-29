//
//  AppStepper.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import RxSwift
import RxCocoa
import RxFlow

class AppStepper: Stepper {
  var steps: PublishRelay<Step> {
    PublishRelay<Step>()
  }
  var initialStep: Step {
    return ReJordSteps.mainTabsSceneIsRequired
  }
}
