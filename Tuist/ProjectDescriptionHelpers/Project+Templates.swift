import ProjectDescription

extension Project {
  public static func app(name: String, platform: Platform, additionalTargets: [String], dependencies: [TargetDependency]) -> Project {
    let bundleId = "com.reJord.bbuyo"
    let projectName = name
    let iOSTarget = "15.0"
    let infoPlist: [String: InfoPlist.Value] = [
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
    return Project(
      name: name,
      organizationName: "reJordiOS",
      packages: [
      ],
      targets: [
        Target(name: projectName,
               platform: .iOS,
               product: .app,
               bundleId: bundleId,
               deploymentTarget: .iOS(targetVersion: iOSTarget, devices: .iphone),
               infoPlist: .extendingDefault(with: infoPlist),
               sources: ["Targets/\(projectName)/Sources/**"],
               resources: ["Targets/\(projectName)/Resources/**"],
               scripts: [.SwiftLintShell],
               dependencies: dependencies
              )
      ],
      schemes: [
        Scheme(name: "\(projectName)-Debug"),
        Scheme(name: "\(projectName)-Release"),
        Scheme(name: "\(projectName)-Alpha")
      ],
      additionalFiles: [],
      resourceSynthesizers: []
    )
  }
}


