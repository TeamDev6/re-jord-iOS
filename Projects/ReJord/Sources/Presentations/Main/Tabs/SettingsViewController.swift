//
//  SettingsViewController.swift
//  ReJord
//
//  Created by 송하민 on 2023/02/04.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import ReJordUI

final class SettingsViewController: UIViewController, Layoutable, View {
  
  
  
  // MARK: - components
  
  
  // MARK: - component options
  
  
  // MARK: - private properties
  
  
  // MARK: - private functions
  
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycles
  
  init(reactor: SettingsReactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setLayout()
  }
  
  
  // MARK: - layout
  
  func setLayout() {
    
  }
  
  // MARK: - bind reactor
  
  func bind(reactor: SettingsReactor) {
    
  }
  
  
  
  
}
