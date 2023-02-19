import ProjectDescription

extension Project {
  
  private static let organizationName = "team.reJord"
  
  public static func app(
    name: String,
    platform: Platform,
    iOSTargetVersion: String,
    dependencies: [TargetDependency]
  ) -> Project {
    
    let infoPlist: [String: InfoPlist.Value] = Dictionary.reJordInfoPlist
    
    let targets = makeAppTargets(
      name: name,
      platform: platform,
      iOSTargetVersion: iOSTargetVersion,
      infoPlist: infoPlist,
      targetScript: [.SwiftLintShell],
      dependencies: dependencies
    )
    
    let baseSettings: [String: SettingValue] = [
      "SWIFT_OBJC_BRIDGING_HEADER": "./Sources/\(name)-Bridging-Header.h"
    ]
    
    return Project(
      name: name,
      organizationName: organizationName,
      options: .options(textSettings: .textSettings(usesTabs: true, indentWidth: 2, tabWidth: 2)),
      packages: [],
      settings: .settings(
        base: baseSettings,
        configurations: [
          .debug(name: "Development", xcconfig: .relativeToRoot("Configurations/XCConfig/Development.xcconfig")),
          .debug(name: "Alpha", xcconfig: .relativeToRoot("Configurations/XCConfig/Alpha.xcconfig")),
          .release(name: "Release", xcconfig: .relativeToRoot("Configurations/XCConfig/Release.xcconfig"))
        ]
      ),
      targets: targets,
      schemes: [
        Scheme(name: "\(name)-Development",
               shared: true,
               buildAction: BuildAction(targets: ["ReJord"]),
               testAction: TestAction.targets(
                ["\(name)Tests"],
                configuration: "Development",
                diagnosticsOptions: [.mainThreadChecker]
               ),
               runAction: RunAction.runAction(configuration: "Development"),
               archiveAction: ArchiveAction.archiveAction(configuration: "Development"),
               analyzeAction: AnalyzeAction.analyzeAction(configuration: "Development")
              ),
        Scheme(name: "\(name)-Alpha",
               shared: true,
               buildAction: BuildAction(targets: ["ReJord"]),
               testAction: TestAction.targets(
                ["\(name)Tests"],
                configuration: "Alpha",
                diagnosticsOptions: [.mainThreadChecker]
               ),
               runAction: RunAction.runAction(configuration: "Alpha"),
               archiveAction: ArchiveAction.archiveAction(configuration: "Alpha"),
               analyzeAction: AnalyzeAction.analyzeAction(configuration: "Alpha")
              ),
        Scheme(name: "\(name)-Release",
               shared: true,
               buildAction: BuildAction(targets: ["ReJord"]),
               testAction: TestAction.targets(
                ["\(name)Tests"],
                configuration: "Release",
                diagnosticsOptions: [.mainThreadChecker]
               ),
               runAction: RunAction.runAction(configuration: "Release"),
               archiveAction: ArchiveAction.archiveAction(configuration: "Release"),
               analyzeAction: AnalyzeAction.analyzeAction(configuration: "Release")
              ),
      ],
      additionalFiles: [],
      resourceSynthesizers: []
    )
  }
  
  public static func frameworkWithDemoApp(
    name: String,
    platform: Platform,
    iOSTargetVersion: String,
    infoPlist: [String: InfoPlist.Value] = [:],
    dependencies: [TargetDependency] = []) -> Project {
      
      var targets = makeFrameworkTargets(
        name: name,
        platform: platform,
        iOSTargetVersion: iOSTargetVersion,
        dependencies: dependencies
      )
      targets.append(
        contentsOf: makeAppTargets(
          name: "\(name)DemoApp",
          platform: platform,
          iOSTargetVersion: iOSTargetVersion,
          infoPlist: infoPlist,
          targetScript: [],
          dependencies: [.target(name: name)]
        )
      )
      
//      let baseSettings: [String: SettingValue] = [
//        "SWIFT_OBJC_BRIDGING_HEADER": "./Sources/\(name)DemoApp-Bridging-Header.h"
//      ]

      return Project(
        name: name,
        organizationName: organizationName,
        settings: Settings.settings(configurations: [
          .debug(name: "Development", xcconfig: .relativeToRoot("Configurations/XCConfig/Development.xcconfig")),
          .debug(name: "Alpha", xcconfig: .relativeToRoot("Configurations/XCConfig/Alpha.xcconfig")),
          .release(name: "Release", xcconfig: .relativeToRoot("Configurations/XCConfig/Release.xcconfig"))
        ]),
        targets: targets
      )
    }
  
  public static func framework(
    name: String,
    platform: Platform,
    iOSTargetVersion: String,
    dependencies: [TargetDependency] = []) -> Project {
      let targets = makeFrameworkTargets(
        name: name,
        platform: platform,
        iOSTargetVersion: iOSTargetVersion,
        dependencies: dependencies
      )
      return Project(
        name: name,
        organizationName: organizationName,
        targets: targets
      )
    }
  
}

private extension Project {
  
  static func makeFrameworkTargets(name: String, platform: Platform, iOSTargetVersion: String, dependencies: [TargetDependency] = []) -> [Target] {
    let sources = Target(name: name,
                         platform: platform,
                         product: .framework,
                         bundleId: "team.dev6.\(name)",
                         deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                         infoPlist: .default,
                         sources: ["Sources/**"],
                         resources: ["Resources/**"],
                         headers: Headers.headers(public: FileList(arrayLiteral: "RxCocoa-Swift.h")),
                         dependencies: dependencies)
     
    let tests = Target(name: "\(name)Tests",
                       platform: platform,
                       product: .unitTests,
                       bundleId: "team.dev6.\(name)Tests",
                       infoPlist: .default,
                       sources: ["Tests/**"],
                       resources: [],
                       dependencies: [
                        .target(name: name),
                        .external(name: "Quick"),
                        .external(name: "Nimble")
                       ])
    return [sources, tests]
    
  }
  
  static func makeAppTargets(
    name: String,
    platform: Platform,
    iOSTargetVersion: String,
    infoPlist: [String: InfoPlist.Value] = [:],
    targetScript: [TargetScript],
    dependencies: [TargetDependency] = []
  ) -> [Target] {
    let platform: Platform = platform
    
    let mainTarget = Target(
      name: name,
      platform: platform,
      product: .app,
      bundleId: "team.dev6.\(name)",
      deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      scripts: targetScript,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "team.dev6.Tests",
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: "\(name)"),
        .external(name: "Quick"),
        .external(name: "Nimble")
      ])
    
    return [mainTarget, testTarget]
  }
  
}
