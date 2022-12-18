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
    case signUpAction(id: String, pwd: String)
  }
  
  enum Mutation {
    case empty
    case idSet(id: String?)
    case passwordSet(password: String?)
    case passwordConfirmSet(password: String?)
  }
  
  struct State {
    var idValue: String? = ""
    var passwordValue: String? = ""
    var passwordIsNotEqual: Bool = false
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
    case .idValueInserted(value: let value):
      return .just(.idSet(id: value))
    case .passwordValueInserted(value: let value):
      return .just(.passwordSet(password: value))
    case .passwordConfirmValueInserted(value: let value):
      return .just(.passwordConfirmSet(password: value))
    case .signUpAction(let id, let pwd):
      self.userSignUp(userId: id, userPassword: pwd)
      return .empty()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .empty:
      break
    case .idSet(id: let id):
      newState.idValue = id
    case .passwordSet(password: let password):
      newState.passwordValue = password
    case .passwordConfirmSet(password: let passwordConfirm):
      newState.passwordIsNotEqual = state.passwordValue != passwordConfirm
    }
    return newState
  }
  
  // MARK: - Private Functions
  
  private func userSignUp(userId: String, userPassword: String) {
    self.usecase.signUp(userId: userId, userPassword: userPassword)
  }
  
}
