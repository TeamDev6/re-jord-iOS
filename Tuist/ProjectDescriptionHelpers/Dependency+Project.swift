//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 2022/12/10.
//

import ProjectDescription

extension TargetDependency {
  public enum Project {}
}

extension TargetDependency.Project {
  public static let ReJordUI = TargetDependency.project(
    target: "ReJordUI",
    path: .relativeToRoot("Projects/ReJordUI")
  )
}

// MARK: TargetDependency

public extension TargetDependency {
  static let rxSwift: TargetDependency = .external(name: "RxSwift")
  static let rxFlow: TargetDependency = .external(name: "RxFlow")
  static let rxDataSources: TargetDependency = .external(name: "RxDataSources")
  static let reactorKit: TargetDependency = .external(name: "ReactorKit")
  static let kingFisher: TargetDependency = .external(name: "Kingfisher")
  static let moya: TargetDependency = .external(name: "Moya")
  static let rxMoya: TargetDependency = .external(name: "RxMoya")
  static let alamofire: TargetDependency = .external(name: "Alamofire")
  static let snapKit: TargetDependency = .external(name: "SnapKit")
  static let swiftyJSON: TargetDependency = .external(name: "SwiftyJSON")
  static let then: TargetDependency = .external(name: "Then")
  static let parchment: TargetDependency = .external(name: "Parchment")
  static let quick: TargetDependency = .external(name: "Quick")
  static let nimble: TargetDependency = .external(name: "Nimble")
  
}



