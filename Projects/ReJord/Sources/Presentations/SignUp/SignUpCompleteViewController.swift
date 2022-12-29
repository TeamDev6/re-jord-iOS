//
//  SignUpCompleteViewController.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/29.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then

final class SignUpCompleteViewController: UIViewController, View {
  
  
  
  // MARK: - components
  
  
  // MARK: - component options
  
  
  // MARK: - private properties
  
  
  // MARK: - private functions
  
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycles
  
  init(reactor: SignUpReactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("\(self) is deinited")
  }
  
  
  // MARK: - layout
  
  
  // MARK: - bind reactor
  
  func bind(reactor: SignUpReactor) {
    
  }
  
  
  
  
}
