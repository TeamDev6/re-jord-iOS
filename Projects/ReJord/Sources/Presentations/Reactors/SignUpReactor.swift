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

enum NickNameStatusType {
  case empty
  case duplicated
  case overCount
  case valid
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
    case nickNameValueInserted(text: String?)
  }
  
  enum Mutation {
    case empty
    case idSet(id: String?)
    case passwordSet(password: String?)
    case passwordConfirmSet(password: String?)
    case setIdValidationResult(availbale: Bool)
    case setNicknameStatus(status: NickNameStatusType)
  }
  
  struct State {
    var idValue: String? = ""
    var passwordValue: String? = ""
    var passwordIsEqual: PasswordConfirmType = .empty
    var idIsAvailable: IdAvailableType = .checkYet
    var nicknameStatus: NickNameStatusType = .empty
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
      guard let id = self.currentState.idValue else { return .empty() }
      return self.checkIDDuplicated(id: id)
        .map { result in
          switch result {
          case .success(_):
            return .setIdValidationResult(availbale: true)
          case .failure(let error):
            self.errorListener.accept(error)
            return .setIdValidationResult(availbale: false)
          }
        }
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
    case .nickNameValueInserted(text: let text):
      guard let text = text else { return .empty() }
      guard !text.isEmpty else { return .just(.setNicknameStatus(status: .empty)) }
      if text.count < 2 || text.count > 10 {
        return .just(.setNicknameStatus(status: .overCount))
      }
      return self.checkNicknameDuplicated(nickname: text)
        .map { result in
          switch result {
          case .success(_):
            return .setNicknameStatus(status: .valid)
          case .failure(_):
            return .setNicknameStatus(status: .duplicated)
          }
        }
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
      newState.passwordIsEqual = .empty
    case .passwordConfirmSet(password: let passwordConfirm):
      guard let passwordConfirm,
            !passwordConfirm.isEmpty else {
        newState.passwordIsEqual = .empty
        return newState
      }
      newState.passwordIsEqual = state.passwordValue == passwordConfirm ? .equal : .notEqual
    case .setIdValidationResult(availbale: let availbale):
      newState.idIsAvailable = availbale ? .available : .duplicated
    case .setNicknameStatus(let status):
      newState.nicknameStatus = status
    }
    return newState
  }
  
  // MARK: - Private Functions
  
  private func userSignUp(userId: String, userPassword: String) -> Observable<Result<Data, ReJordError>> {
    return self.usecase.signUp(userId: userId, userPassword: userPassword)
  }
  
  private func checkIDDuplicated(id: String) -> Observable<Result<Data, ReJordError>> {
    return self.usecase.checkIdDuplication(id: id)
  }
  
  private func checkNicknameDuplicated(nickname: String) -> Observable<Result<Data, ReJordError>> {
    return self.usecase.checkNicknameDuplicated(nickname: nickname)
  }
  
  
}
