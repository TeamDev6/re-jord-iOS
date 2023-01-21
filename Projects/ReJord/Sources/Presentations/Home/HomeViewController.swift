//
//  HomeViewController.swift
//  ReJord
//
//  Created by 송하민 on 2023/01/01.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import ReJordUI

final class HomeViewController: UIViewController, Layoutable, View {

  
  
  // MARK: - components
  
  
  // MARK: - component options
  
  
  // MARK: - private properties
  
  
  // MARK: - private functions
  
  
  // MARK: - disposebag
  
  var disposeBag = DisposeBag()
  
  
  // MARK: - life cycles
  
  init(reactor: HomeReactor) {
    super.init(nibName: nil, bundle: nil)
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .gray
    self.setLayout()
  }
  
  
  // MARK: - layout
  
  func setLayout() {
    
  }
  
  
  // MARK: - bind reactor
  
  func bind(reactor: HomeReactor) {
    
  }
  
  
  
  
}
