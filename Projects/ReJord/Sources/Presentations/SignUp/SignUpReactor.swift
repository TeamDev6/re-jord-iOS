//
//  SignUpReactor.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxFlow

final class SignUpReactor: Reactor {
  
  // MARK: - Reactor
  
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  // MARK: - Private Properties
  
  var initialState: State = State()
  var errorListener: PublishRelay = PublishRelay<ReJordError>()
  
  // MARK: - Life Cycle
  
  init() {
    
  }
  
  deinit {
    
  }
  
}

extension SignUpReactor: Stepper {
  var steps: PublishRelay<Step> {
    PublishRelay<Step>()
  }
  var initialStep: Step {
    return ReJordSteps.signUpIsRequired
  }
}
