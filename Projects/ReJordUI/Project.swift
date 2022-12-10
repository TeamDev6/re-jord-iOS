//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 2022/12/10.
//
import ProjectDescription
import ProjectDescriptionHelpers


// MARK: - Project

private let projectName = "ReJordUI"
private let iOSTargetVersion = "15.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(
  name: projectName,
  platform: .iOS,
  iOSTargetVersion: iOSTargetVersion,
  infoPlist: infoPlist,
  dependencies: [
    .external(name: "SnapKit")
  ]
)
