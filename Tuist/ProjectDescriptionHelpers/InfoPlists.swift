//
//  InfoPlist.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 2022/12/10.
//

import ProjectDescription

public extension Dictionary<String, InfoPlist.Value> {
  
  static let reJordInfoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UILaunchStoryboardName": "LaunchScreen",
    "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "UIUserInterfaceStyle": "Light",
    "UIApplicationSceneManifest": [
      "UIApplicationSupportsMultipleScenes": true,
      "UISceneConfigurations": [
        "UIWindowSceneSessionRoleApplication": [[
          "UISceneConfigurationName": "Default Configuration",
          "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
        ]]
      ]
    ]
  ]
}
