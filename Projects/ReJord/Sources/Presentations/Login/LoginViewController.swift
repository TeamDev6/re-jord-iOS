//
//  LoginViewController.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/30.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import ReJordUI

final class LoginViewController: View {
  
  
  
  // MARK: - components
  
  
  // MARK: - component options
  
  
  // MARK: - private properties
  
  
  // MARK: - private functions
  
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycles
  
  init(reactor: LoginReactor) {
    self.reactor = reactor
  }
  
  
  // MARK: - layout
  
  
  // MARK: - bind reactor
  
  func bind(reactor: LoginReactor) {
    
  }
  
  
  
  
}
