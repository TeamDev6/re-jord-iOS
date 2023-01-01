//
//  HomeReactor.swift
//  ReJord
//
//  Created by 송하민 on 2023/01/01.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxFlow

final class HomeReactor: Reactor, Stepper {
  
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
  private let usecase: HomeUsecase
  
  
  // MARK: - DisposeBag
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  init(repository: HomeRepository) {
    self.usecase = HomeUsecase(repository: repository)
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
