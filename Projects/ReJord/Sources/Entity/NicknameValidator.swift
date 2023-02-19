//
//  NicknameValidator.swift
//  ReJord
//
//  Created by 송하민 on 2023/02/19.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import Foundation
import RxSwift

final class NicknameValidator {
	
	// MARK: - private properties
	
	private let minimumNicknameLength = 2
	private let maximumNicknameLength = 10
	
	
	
	// MARK: - internal func
	
	func checkNicknameLength(nickname: String?) -> Observable<Bool> {
		guard let nickname, nickname.count >= self.minimumNicknameLength, nickname.count <= self.maximumNicknameLength else { return Observable.just(false) }
		return Observable.just(true)
	}
	
	func checkNicknameRegex(nickname: String?) -> Observable<Bool> {
		guard let nickname,
					let _ = nickname.range(of: ".*[^A-Z가-힣ㄱ-ㅎㅏ-ㅣa-z0-9].*", options: .regularExpression) else {
			return Observable.just(false)
		}
		return Observable.just(true)
	}
	
	
}
