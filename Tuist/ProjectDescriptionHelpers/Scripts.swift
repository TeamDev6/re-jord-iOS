//
//  Scripts.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 2022/12/09.
//

import ProjectDescription

public extension TargetScript {
  
  // MARK: - SwiftLint
  static let SwiftLintShell = TargetScript.pre(
    path: .relativeToRoot("Scripts/SwiftLintRunScript.sh"),
    name: "SwiftLintShell"
  )
  
  
  // MARK: - Firebase Crashlytics
  static let crashlyticsScript = TargetScript.pre(
    path: "Scripts/FBCrashlyticsRunScript.sh",
    name: "Firebase Crashlytics"
  )
  
}
