//
//  ReJordSteps.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import RxFlow

enum ReJordSteps: Step {
  case signInIsRequired
  case signUpIsRequired
  case signUpCompleteSceneIsRequired(signUpResult: SignUpResult)
  case mainTabsSceneIsRequired
  case homeTabIsRequired
  case challengeTabIsRequired
  case settingsTabIsRequired
}
