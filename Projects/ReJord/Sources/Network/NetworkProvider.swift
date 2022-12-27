//
//  NetworkProvider.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import Alamofire
import RxSwift
import RxCocoa

protocol Networkable {
  associatedtype Target
  func request(target: Target) -> Observable<Result<Data, Error>>
}

class NetworkProvider<Target: TargetType> {
  private var isStubbing = false
  public var provider: MoyaProvider<Target>
  public let dispatchQueue = DispatchQueue(label: "queue.network.rejord", qos: .userInteractive)
  
  let loggerPlugin = NetworkLoggerPlugin()
  
  let customEndpointClosure = { (target: Target) -> Endpoint in
    
    return Endpoint(
      url: URL(target: target).absoluteString,
      sampleResponseClosure: { .networkResponse(200, target.sampleData) },
      method: target.method,
      task: target.task,
      httpHeaderFields: target.headers
    )
  }
  
  init(isStub: Bool = false) {
    self.isStubbing = isStub
    if isStub {
      self.provider = MoyaProvider<Target>(
        endpointClosure: customEndpointClosure,
        stubClosure: MoyaProvider.immediatelyStub,
        plugins: [loggerPlugin]
      )
    } else {
      self.provider = MoyaProvider<Target>(
        endpointClosure: MoyaProvider.defaultEndpointMapping,
        requestClosure: MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: MoyaProvider.neverStub,
        callbackQueue: nil,
        session: AlamofireSession.configuration,
        plugins: [loggerPlugin],
        trackInflights: false
      )
    }
  }
}

extension NetworkProvider: Networkable {
  
  func request(target: Target) -> Observable<Result<Data, Error>> {
    
    if self.isStubbing {
      let stubRequest = self.provider.rx.request(target, callbackQueue: self.dispatchQueue)
      
      return stubRequest
        .asObservable()
        .map { response in
          return .success(response.data)
        }
        .catch { error in
          return .just(.failure(error))
        }
    } else {
      let online = networkEnable()
      let realRequest = self.provider.rx.request(target, callbackQueue: self.dispatchQueue)

      return online
        .filter {( $0 )}
        .take(1)
        .flatMap { _ in
          realRequest.filterSuccessfulStatusCodes()
            .map({ response in
              return .success(response.data)
            })
            .retry(3)
            .catch { error in
              return .just(.failure(error))
            }
        }
    }
  }
}

public class AlamofireSession: Alamofire.Session {
  
  public static let configuration: Alamofire.Session = {
    let configuration = URLSessionConfiguration.default
    configuration.headers = HTTPHeaders.default
    configuration.timeoutIntervalForRequest = 60
    configuration.timeoutIntervalForResource = 60
    configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
    return Alamofire.Session(configuration: configuration)
  }()
}

private func networkEnable() -> Observable<Bool> {
  ReachabilityManager.shared.reach
}

// MARK: - ReachabilityManager

public class ReachabilityManager: NSObject {
  
  internal static let shared = ReachabilityManager()

  let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
  var reach: Observable<Bool> {
    reachSubject.asObservable()
      .do(onNext: { reachable in
        if !reachable {
          print("네트워크에 연결할 수 없습니다.")
        }
      })
  }
  
  override private init() {
    super.init()
    NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { status in
      let reachable = (status == .notReachable || status == .unknown) ? false : true
      self.reachSubject.onNext(reachable)
    })
  }
}
