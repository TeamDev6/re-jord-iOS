import ProjectDescription

extension Project {
  
  public static func app(name: String, platform: Platform, additionalTargets: [String], dependencies: [TargetDependency]) -> Project {
    
    let bundleId = "com.reJord.bbuyo"
    let projectName = name
    let iOS_target = "15.0"
    
    return Project(name: name,
                   organizationName: "reJordiOS",
                   packages: [
                   ],
                   targets: [
                    Target(name: projectName,
                           platform: .iOS,
                           product: .app,
                           bundleId: bundleId,
                           deploymentTarget: .iOS(targetVersion: iOS_target, devices: .iphone),
                           infoPlist: .default,
                           sources: ["Targets/\(projectName)/Sources/**"],
                           resources: ["Targets/\(projectName)/Resources/**"],
                           scripts: [],
                           dependencies: dependencies
                          )
                   ],
                   schemes: [
                    Scheme(name: "\(projectName)-Debug"),
                    Scheme(name: "\(projectName)-Release"),
                    Scheme(name: "\(projectName)-Alpha"),
                   ],
                   additionalFiles: [],
                   resourceSynthesizers: []
    )
  }
  //
  //  // MARK: - Private
  //
  //  /// Helper function to create a framework target and an associated unit test target
  //  private static func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
  //    let sources = Target(name: name,
  //                         platform: platform,
  //                         product: .framework,
  //                         bundleId: "io.tuist.\(name)",
  //                         infoPlist: .default,
  //                         sources: ["Targets/\(name)/Sources/**"],
  //                         resources: [],
  //                         dependencies: [])
  //    let tests = Target(name: "\(name)Tests",
  //                       platform: platform,
  //                       product: .unitTests,
  //                       bundleId: "io.tuist.\(name)Tests",
  //                       infoPlist: .default,
  //                       sources: ["Targets/\(name)/Tests/**"],
  //                       resources: [],
  //                       dependencies: [.target(name: name)])
  //    return [sources, tests]
  //  }
  //
  //  /// Helper function to create the application target and the unit test target.
  //  private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
  //    let platform: Platform = platform
  //    let infoPlist: [String: InfoPlist.Value] = [
  //      "CFBundleShortVersionString": "1.0",
  //      "CFBundleVersion": "1",
  //      "UIMainStoryboardFile": "",
  //      "UILaunchStoryboardName": "LaunchScreen"
  //    ]
  //
  //    let mainTarget = Target(
  //      name: name,
  //      platform: platform,
  //      product: .app,
  //      bundleId: "io.tuist.\(name)",
  //      infoPlist: .extendingDefault(with: infoPlist),
  //      sources: ["Targets/\(name)/Sources/**"],
  //      resources: ["Targets/\(name)/Resources/**"],
  //      dependencies: dependencies
  //    )
  //
  //    let testTarget = Target(
  //      name: "\(name)Tests",
  //      platform: platform,
  //      product: .unitTests,
  //      bundleId: "io.tuist.\(name)Tests",
  //      infoPlist: .default,
  //      sources: ["Targets/\(name)/Tests/**"],
  //      dependencies: [
  //        .target(name: "\(name)")
  //      ])
  //    return [mainTarget, testTarget]
  //  }
}
