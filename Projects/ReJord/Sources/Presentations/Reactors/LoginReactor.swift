//
//  LoginReactor.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/30.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxFlow

final class LoginReactor: Reactor, Stepper {
  
  // MARK: - Reactor
  
  enum Action {
    case gotoSignUpScene
    case errorOccured
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  // MARK: - Properties
  
  var initialState: State = State()
  var steps: PublishRelay<Step> = PublishRelay()
  
  private var errorListener: PublishRelay = PublishRelay<ReJordError>()
  private let usecase: SignUpUsecase
  
  
  // MARK: - DisposeBag
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  init(repository: SignUpRepository) {
    usecase = SignUpUsecase(repository: repository)
  }
  
  deinit {
    print("SignUpReactor is deinit")
  }

  
  // MARK: - Reactor Action
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .gotoSignUpScene:
      self.steps.accept(ReJordSteps.signUpIsRequired)
      return .empty()
    case .errorOccured:
      return .empty()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
  }
  
  // MARK: - Private Functions
  
  
}
