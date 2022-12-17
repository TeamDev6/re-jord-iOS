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
    "UILaunchScreen": [:],
    "UIAppFonts": [
      "Roboto-Black.ttf",
      "Roboto-BlackItalic.ttf",
      "Roboto-Bold.ttf",
      "Roboto-BoldItalic.ttf",
      "Roboto-Italic.ttf",
      "Roboto-Light.ttf",
      "Roboto-LightItalic.ttf",
      "Roboto-Medium.ttf",
      "Roboto-MediumItalic.ttf",
      "Roboto-Regular.ttf",
      "Roboto-Thin.ttf",
      "Roboto-ThinItalic.ttf"
    ]
]

let project = Project.frameworkWithDemoApp(
  name: projectName,
  platform: .iOS,
  iOSTargetVersion: iOSTargetVersion,
  infoPlist: infoPlist,
  dependencies: [
    .external(name: "SnapKit"),
    .external(name: "RxSwift"),
    .external(name: "RxCocoa")
  ]
)
