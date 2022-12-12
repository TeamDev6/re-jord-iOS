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

final class SignUpReactor: Reactor, Stepper {
  
  
  
  // MARK: - Reactor
  
  enum Action {
    case signUpAction
  }
  
  enum Mutation {
    
  }
  
  struct State {
    let idValue: String = ""
    let passwordValue: String = ""
  }
  
  // MARK: - Properties
  
  var initialState: State = State()
  var steps: PublishRelay<Step> = PublishRelay()
  private var errorListener: PublishRelay = PublishRelay<ReJordError>()
  private let usecase: SignUpUsecase
  
  
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
    case .signUpAction:
      self.userSignUp()
      return .empty()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
  }
  
  // MARK: - Private Functions
  
  private func userSignUp() {
    self.usecase.signUp(userId: "testID", userPassword: "testPWD")
  }
  
}
