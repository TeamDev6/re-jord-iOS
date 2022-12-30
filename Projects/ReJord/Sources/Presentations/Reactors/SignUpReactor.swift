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

enum PasswordConfirmType {
  case empty
  case notEqual
  case equal
}

enum IdAvailableType {
  case checkYet
  case available
  case duplicated
}

final class SignUpReactor: Reactor, Stepper {
  
  
  // MARK: - Reactor
  
  enum Action {
    case idValueInserted(value: String?)
    case passwordValueInserted(value: String?)
    case passwordConfirmValueInserted(value: String?)
    case checkIdDuplication
    case signUpAction
    case errorOccured
  }
  
  enum Mutation {
    case empty
    case idSet(id: String?)
    case passwordSet(password: String?)
    case passwordConfirmSet(password: String?)
    case setIdValidationResult(availbale: Bool)
  }
  
  struct State {
    var idValue: String? = ""
    var passwordValue: String? = ""
    var passwordIsEqual: PasswordConfirmType = .empty
    var idIsAvailable: IdAvailableType = .checkYet
  }
  
  // MARK: - Properties
  
  var initialState: State = State()
  var steps: PublishRelay<Step> = PublishRelay()
  let disposeBag = DisposeBag()
  
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
    case .checkIdDuplication:
//      guard let id = self.currentState.idValue else { return .empty() }
      return .just(.setIdValidationResult(availbale: true))
//      return self.check(id: id)
//        .map { result in
//          switch result {
//          case .success(_):
//            // 분기에 따라 true/false 설정, 아직 api 나오지 않아 true 로 하드코딩
//            return .setIdValidationResult(availbale: true)
//          case .failure(let error):
//            self.errorListener.accept(error)
//            return .empty
//          }
//        }
    case .signUpAction:
      return self.userSignUp(userId: currentState.idValue ?? "", userPassword: currentState.passwordValue ?? "")
        .map { result in
          switch result {
          case .success(_):
            self.steps.accept(ReJordSteps.signUpCompleteSceneIsRequired)
            return .empty
          case .failure(let error):
            self.errorListener.accept(error)
            // TODO: 테스트 이후 step 정상화 할 것
            self.steps.accept(ReJordSteps.signUpCompleteSceneIsRequired)
            return .empty
          }
        }
    case .errorOccured:
      self.errorListener.accept(ReJordError.cantBindReactor)
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
      guard let passwordConfirm, !passwordConfirm.isEmpty else { return newState }
      newState.passwordIsEqual = state.passwordValue == passwordConfirm ? .equal : .notEqual
    case .setIdValidationResult(availbale: let availbale):
      if availbale {
        newState.idIsAvailable = .available
      } else {
        newState.idIsAvailable = .duplicated
      }
    }
    return newState
  }
  
  // MARK: - Private Functions
  
  private func userSignUp(userId: String, userPassword: String) -> Observable<Result<Data, ReJordError>> {
    return self.usecase.signUp(userId: userId, userPassword: userPassword)
  }
  
  private func check(id: String) -> Observable<Result<Data, ReJordError>> {
    return self.usecase.checkIdDuplication(id: id)
//      .map { result in
//        switch result {
//        case .success(let data):
//          return .available
//        case .failure(let error):
//          self.errorListener.accept(.serverError)
//          return
//        }
//      }
  }
  
}
