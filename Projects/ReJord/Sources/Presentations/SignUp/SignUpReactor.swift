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
    case idValueInserted(value: String?)
    case passwordValueInserted(value: String?)
    case passwordConfirmValueInserted(value: String?)
    case signUpAction
  }
  
  enum Mutation {
    case idSet(id: String?)
    case passwordSet(passowrd: String?)
  }
  
  struct State {
    let idValue: String = ""
    let passwordValue: String = ""
    let passwordIsNotEqual: Bool = false
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
    case .idValueInserted(value: let value):
      return .just(.idSet(id: value))
    case .passwordValueInserted(value: let value):
      return .just(.passwordSet(passowrd: value))
    case .passwordConfirmValueInserted(value: let _):
      return .empty()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    switch mutation {
    
    case .idSet(id: let id):
      <#code#>
    case .passwordSet(passowrd: let passowrd):
      <#code#>
    }
  }
  
  // MARK: - Private Functions
  
  private func userSignUp() {
    self.usecase.signUp(userId: "testID", userPassword: "testPWD")
  }
  
}
