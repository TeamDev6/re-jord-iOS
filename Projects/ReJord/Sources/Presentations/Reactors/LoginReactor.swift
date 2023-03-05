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
	
	enum UserDefaultKeys: String {
		case UserTokens
	}
  
  // MARK: - Reactor
  
  enum Action {
    case gotoSignUpScene
    case errorOccured
    case idInput(id: String?)
    case passwordInput(password: String?)
    case loginAction
  }
  
  enum Mutation {
    case empty
    case setId(id: String?)
    case setPassword(password: String?)
    case setLoginFailure(isFail: Pulse<Bool>)
  }
  
  struct State {
    var idValue: String = ""
    var passwordValue: String = ""
    var isLoginFail: Pulse<Bool> = Pulse(wrappedValue: false)
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
      return .empty()
    case .errorOccured:
      return .empty()
    case .idInput(id: let id):
      return .just(.setId(id: id))
    case .passwordInput(password: let password):
      return .just(.setPassword(password: password))
    case .loginAction:
      return self.login(id: currentState.idValue, password: currentState.passwordValue)
					.map { result in
						switch result {
							case .success(let data):
								let token = data.tokens
								do {
									let data = try JSONEncoder().encode(token)
									UserDefaults.standard.set(data, forKey: UserDefaultKeys.UserTokens.rawValue)
								} catch {
									print("json encoder has a error")
									return .empty
								}
								self.steps.accept(ReJordSteps.mainTabsSceneIsRequired)
								return .empty
							case .failure(_):
								self.action.onNext(.errorOccured)
								return .setLoginFailure(isFail: Pulse<Bool>(wrappedValue: true))
						}
					}
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .empty:
      break
    case .setId(let id):
      guard let id = id else { return newState }
      newState.idValue = id
    case .setPassword(let password):
      guard let password = password else { return newState }
      newState.passwordValue = password
    case .setLoginFailure(let isFail):
      newState.isLoginFail = isFail
    }
    return newState
  }
  
  // MARK: - Private Functions
  
  private func login(id: String, password: String) -> Observable<Result<LoginResult, ReJordError>> {
    return self.loginUsecase.login(id: id, password: password)
  }
  
  
}
