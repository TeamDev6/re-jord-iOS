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
    case loginAction(userId: String, userPassword: String)
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  // MARK: - Properties
  
  var initialState: State = State()
  var steps: PublishRelay<Step> = PublishRelay()
  
  private var errorListener: PublishRelay = PublishRelay<ReJordError>()
  private let loginUsecase: LoginUsecase
  
  
  // MARK: - DisposeBag
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  init(repository: LoginRepository) {
    self.loginUsecase = LoginUsecase(repository: repository)
  }
  
  deinit {
    print("SignUpReactor is deinit")
  }

  
  // MARK: - Reactor Action
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .gotoSignUpScene:
      self.steps.accept(ReJordSteps.signUpIsRequired)
//      self.steps.accept(ReJordSteps.signUpCompleteSceneIsRequired)
      return .empty()
    case .errorOccured:
      return .empty()
    case .loginAction(let id, let password):
//      self.steps.accept(ReJordSteps.homeSceneIsRequired)
      self.login(id: id, password: password)
        
      return .empty()
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
  }
  
  // MARK: - Private Functions
  
  private func login(id: String, password: String) -> Observable<Result<Data, ReJordError>> {
    return self.loginUsecase.login(id: id, password: password)
  }
  
  
}
