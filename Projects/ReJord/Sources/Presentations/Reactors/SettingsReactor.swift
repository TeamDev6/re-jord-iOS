//
//  SettingsReactor.swift
//  ReJord
//
//  Created by 송하민 on 2023/02/04.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxFlow


final class SettingsReactor: Reactor, Stepper {
  
  // MARK: - Reactor
  
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  // MARK: - Properties
  
  var initialState: State = State()
  var steps: PublishRelay<Step> = PublishRelay()
  
  private var errorListener: PublishRelay = PublishRelay<ReJordError>()
//  private let usecase: <#Usecase#>
  
  
  // MARK: - DisposeBag
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
//  init(repository: <#Repository#>) {
//    usecase = <#Usecase#>
//  }
  init() {
    
  }
  
  deinit {
    print("\(self) is deinit")
  }
  
  
  // MARK: - Reactor Action
  
  func mutate(action: Action) -> Observable<Mutation> {
    
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
  }
  
  // MARK: - Private Functions
  
  
}
