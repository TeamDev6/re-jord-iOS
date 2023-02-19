//
//  NicknameValidator.swift
//  ReJord
//
//  Created by 송하민 on 2023/02/19.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import Foundation

final class NicknameValidator {
	
	// MARK: - private properties
	
	private let minimumNicknameLength = 2
	private let maximumNicknameLength = 10
	
	
	
	// MARK: - internal func
	
	func checkNicknameLength(nickname: String?) -> Bool {
		guard let nickname, nickname.count >= self.minimumNicknameLength, nickname.count <= self.maximumNicknameLength else { return false }
		return true
	}
	
	func checkNicknameRegex(nickname: String?) -> Bool {
		
		return true
	}
	
	
}
