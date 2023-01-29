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
  case invalid
  case valid
}

final class SignUpReactor: Reactor, Stepper {
  
  
  // MARK: - Reactor
  
  enum Action {
    case errorOccured
    case idValueInserted(value: String?)
    case passwordValueInserted(value: String?)
    case passwordConfirmValueInserted(value: String?)
    case checkIdDuplication
    case signUpAction
    case nicknameInputed(text: String?)
    case needNicknameValidation(nickname: String?)
    case updateUserInformation(signUpResult: SignUpResult?)
    
  }
  
  enum Mutation {
    case empty
    case idSet(id: String?)
    case passwordSet(password: String?)
    case passwordConfirmSet(password: String?)
    case setIdValidationResult(availbale: Bool)
    case setDefaultNickname(text: String?)
    case setNicknameStatus(status: NickNameStatusType)
    case setUserInformationUpdatable(_: Bool)
  }
  
  struct State {
    var idValue: String? = ""
    var passwordValue: String? = ""
    var passwordIsEqual: PasswordConfirmType = .empty
    var idIsAvailable: IdAvailableType = .checkYet
    var defaultNickname: String? = ""
    var nicknameStatus: NickNameStatusType = .empty
  }
  
  // MARK: - Properties
  
  var initialState: State = State()
  var steps: PublishRelay<Step> = PublishRelay()
  let disposeBag = DisposeBag()
  
  private var errorListener: PublishRelay = PublishRelay<ReJordError>()
  private let signUpUsecase: SignUpUsecase
  
  
  // MARK: - Life Cycle
  
  init(repository: SignUpRepository, signUpResult: SignUpResult?) {
    self.signUpUsecase = SignUpUsecase(repository: repository)
    self.action.onNext(.nicknameInputed(text: signUpResult?.nickname))
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
          case .success(let signUpResult):
            UserDefaults.standard.set(try? PropertyListEncoder().encode(signUpResult), forKey: "signUpResult")
            self.steps.accept(ReJordSteps.signUpCompleteSceneIsRequired(signUpResult: signUpResult))
            return .empty
          case .failure(let error):
            self.errorListener.accept(error)
            return .empty
          }
        }
    case .errorOccured:
      self.errorListener.accept(ReJordError.cantBindReactor)
      return .empty()
    case .nicknameInputed(let nickname):
      return .just(.setDefaultNickname(text: nickname))
      
    case .needNicknameValidation(nickname: let nickname):
      return self.signUpUsecase.validateNickname(nickname: nickname)
        .map { isValid in
          return .setUserInformationUpdatable(isValid)
        }
    case .updateUserInformation(signUpResult: let signUpResult):
      guard let nickname = signUpResult?.nickname,
            let uid = signUpResult?.uid else { return .empty() }
      return self.modifyUserInformation(nickname: nickname, uid: uid)
        .map { result in
          switch result {
          case .success(_):
            return .setNicknameStatus(status: .valid)
          case .failure(let error):
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
    case .setDefaultNickname(text: let defaultNickname):
      newState.defaultNickname = defaultNickname
    case .setUserInformationUpdatable(let isUserInformationUpdatable):
      newState.nicknameStatus = isUserInformationUpdatable ? .valid : .invalid
    }
    return newState
  }
  
  // MARK: - Private Functions
  
  private func userSignUp(userId: String, userPassword: String) -> Observable<Result<SignUpResult, ReJordError>> {
    return self.signUpUsecase.signUp(userId: userId, userPassword: userPassword)
  }
  
  private func checkIDDuplicated(id: String) -> Observable<Result<Data, ReJordError>> {
    return self.signUpUsecase.checkIdDuplication(id: id)
  }
  
  private func validateNickname(nickname: String?) -> Observable<Bool> {
    return self.signUpUsecase.validateNickname(nickname: nickname)
  }
  
  private func modifyUserInformation(nickname: String, uid: String) -> Observable<Result<Data, ReJordError>> {
    return self.signUpUsecase.modifyUserInformation(nickname: nickname, uid: uid)
  }
  
  
}
