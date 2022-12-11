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
    case signUpAction
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  // MARK: - Properties
  
  var initialState: State = State()
  private var errorListener: PublishRelay = PublishRelay<ReJordError>()
  private let usecase: SignUpUsecase
  
  
  // MARK: - Life Cycle
  
  init(repository: SignUpRepository) {
    print("initiii")
    usecase = SignUpUsecase(repository: repository)
  }
  
  deinit {
    print("SignUpReactor is deinit")
  }

  
  // MARK: - Reactor Action
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .signUpAction:
      self.usecase.signUp()
      return .empty()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
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
