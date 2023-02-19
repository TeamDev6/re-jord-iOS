//
//  SignUpUsecase.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpUsecase {
  
	// MARK: - private properties
  
	private let repository: SignUpRepository
	private let nicknameValidator = NicknameValidator()
  
	
	// MARK: - life cycle
	
  init(repository: SignUpRepository) {
    self.repository = repository
  }
	
	// MARK: - internal func
  
  func signUp(userId id: String, userPassword password: String) -> Observable<Result<SignUpResult, ReJordError>> {
    return self.repository.signUp(userId: id, userPassword: password)
  }
  
  func checkIdDuplication(id: String) -> Observable<Result<Data, ReJordError>> {
    return self.repository.checkId(id: id)
  }
  
  func validateNickname(nickname: String?) -> Observable<Bool> {
		return self.nicknameValidator.checkNicknameLength(nickname: nickname)
			.flatMap { isLengthValidated -> Observable<Bool> in
				if isLengthValidated {
					return self.nicknameValidator.checkNicknameRegex(nickname: nickname)
				} else {
					return .just(false)
				}
			}
			.flatMap { isRegexValidated -> Observable<Bool> in
				return .just(isRegexValidated)
			}
			
  }
  
  func modifyUserInformation(nickname: String, uid: String) -> Observable<Result<Data, ReJordError>> {
    return self.repository.modifyUserInformation(nickname: nickname, uid: uid)
  }
  
}
